# ECS
# -----------------------------------------------------------------------------
locals {
  name = "${var.env_short}-sisorg-cluster"
  sisorg_cluster_tags = {
    name                      = "${var.env_short}-sisorg-cluster"
    "sisorg:service"          = "Core"
    "sisorg:environment"      = var.env_short
    "sisorg:application"      = "ECS"
    "sisorg:taggingVersion"   = "1.0.0"
    "sisorg:organization"     = var.org_account
    "sisorg:automated"        = "yes"
    "tostop-${var.env_short}" = var.env_stop_resources
    AmazonECSManaged          = true
  }
}

resource "aws_iam_role" "sisorg_ecs_role" {
  name               = "${var.env_short}ECSRole"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
  tags = {
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "ECS"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

resource "aws_iam_role_policy_attachment" "sisorg_ecs_policy" {
  role       = aws_iam_role.sisorg_ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "sisorg_ecs_profile" {
  name = "${var.env_short}InstanceRole1"
  role = aws_iam_role.sisorg_ecs_role.name
}

resource "tls_private_key" "sisorg_cluster_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "sisorg_ec2_kp" {
  key_name   = "sisorg_ec2_${var.env_short}"
  public_key = tls_private_key.sisorg_cluster_pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.sisorg_cluster_pk.private_key_pem}' > ./sisorg_ec2_${var.env_short}.pem"
  }
  tags = {
    "sisorg:service"        = "Core"
    "sisorg:environment"    = var.env_short
    "sisorg:application"    = "ECS"
    "sisorg:taggingVersion" = "1.0.0"
    "sisorg:organization"   = var.org_account
    "sisorg:automated"      = "yes"
  }
}

################################################################################
# Cluster
################################################################################

module "ecs_sisorg_cluster" {
  source       = "registry.terraform.io/terraform-aws-modules/ecs/aws"
  cluster_name = local.name
  cluster_settings = {
    "name" : "containerInsights",
    "value" : "disabled"
  }


  # Capacity provider - autoscaling groups
  default_capacity_provider_use_fargate = false
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 0
        base   = 0
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 0
      }
    }
  }
  autoscaling_capacity_providers = {
    # On-demand instances
    capacity-sisorg = {
      auto_scaling_group_arn         = module.autoscaling["capacity-sisorg"].autoscaling_group_arn
      managed_termination_protection = "DISABLED"

      managed_scaling = {
        maximum_scaling_step_size = 4
        minimum_scaling_step_size = 2
        status                    = "ENABLED"
        target_capacity           = 80
      }

      default_capacity_provider_strategy = {
        weight = 0
      }
    }
  }

}

################################################################################
# Supporting Resources
################################################################################

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html#ecs-optimized-ami-linux
data "aws_ssm_parameter" "ecs_optimized_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended"
}

module "autoscaling" {
  source = "registry.terraform.io/terraform-aws-modules/autoscaling/aws"
  for_each = {
    # On-demand instances

    capacity-sisorg = {
      instance_type              = "t3.medium"
      use_mixed_instances_policy = false
      mixed_instances_policy = {}
      min_size                   = 1
      max_size                   = 1
      desired_size               = 1
      user_data                  = <<-EOT
        #!/bin/bash
        cat <<'EOF' >> /etc/ecs/ecs.config
        ECS_CLUSTER=${local.name}
        EOF
      EOT
    }
  }

  name          = "${local.name}-${each.key}"
  key_name      = aws_key_pair.sisorg_ec2_kp.key_name
  image_id      = jsondecode(data.aws_ssm_parameter.ecs_optimized_ami.value)["image_id"]
  instance_type = each.value.instance_type

  security_groups = [aws_security_group.sisorg_sg_internal.id]
  user_data = base64encode(each.value.user_data)
  ignore_desired_capacity_changes = true
  create_iam_instance_profile     = false
  iam_instance_profile_arn        = aws_iam_instance_profile.sisorg_ecs_profile.arn
  iam_role_name                   = local.name
  iam_role_description            = "ECS role for ${local.name}"
  iam_role_policies = {
    AmazonEC2ContainerServiceforEC2Role = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    AmazonSSMManagedInstanceCore        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  vpc_zone_identifier = [aws_subnet.sisorg_subnet_9_containers.id, aws_subnet.sisorg_subnet_10_containers.id]
  health_check_type = "EC2"

  block_device_mappings = [
    {
      device_name = "/dev/xvda"
      ebs = {
        name                  = "test"
        volume_size = 30 // Size in GiB
        delete_on_termination = true
        volume_type           = "gp3"
      }
    }
  ]
  # https://github.com/hashicorp/terraform-provider-aws/issues/12582
  autoscaling_group_tags = {
    AmazonECSManaged = true
  }

  # Required for  managed_termination_protection = "ENABLED"
  protect_from_scale_in = false

  # Spot instances  
  use_mixed_instances_policy = each.value.use_mixed_instances_policy
  mixed_instances_policy     = each.value.mixed_instances_policy
  min_size                   = each.value.min_size
  max_size                   = each.value.max_size
}


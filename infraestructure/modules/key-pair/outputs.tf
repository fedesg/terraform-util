# Outputs the name of the created SSH key.
output "key_name" {
  description = "The name of the SSH key"
  value       = aws_key_pair.sisorg_ec2_kp.key_name
}


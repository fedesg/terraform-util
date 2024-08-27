# Generates a new private key using the specified algorithm and key size.
resource "tls_private_key" "sisorg_cluster_pk" {
  algorithm = var.algorithm_type # Type of algorithm to use (e.g., RSA).
  rsa_bits  = var.rsa_bits       # Number of bits in the key (e.g., 4096).
}

# Creates an EC2 key pair using the generated public key.
resource "aws_key_pair" "sisorg_ec2_kp" {
  key_name   = var.key_pair_ec2                                     # Name of the key pair in AWS.
  public_key = tls_private_key.sisorg_cluster_pk.public_key_openssh # Public key in OpenSSH format.

  # Saves the private key to a local file.
  provisioner "local-exec" {
    command = "echo '${tls_private_key.sisorg_cluster_pk.private_key_pem}' > ./files/sisorg_ec2_${var.env_short}.pem"
  }
}


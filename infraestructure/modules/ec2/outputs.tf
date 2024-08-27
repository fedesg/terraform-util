# Outputs the ID of the created EC2 instance.
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

# Outputs the ID of the primary network interface.
output "primary_network_interface_id" {
  description = "The ID of the primary network interface"
  value       = aws_network_interface.primary.id
}

# Outputs the ID of the trunk network interface.
output "trunk_network_interface_id" {
  description = "The ID of the trunk network interface"
  value       = aws_network_interface.trunk.id
}

# Outputs the name of the SSH key pair used.
output "key_name" {
  description = "The name of the key pair used for the EC2 instance"
  value       = aws_instance.this.key_name
}

# Specifies the algorithm type to use for generating the key.
variable "algorithm_type" {
  description = "The type of the SSH key to use"
  type        = string
}

# Specifies the number of bits for the RSA key.
variable "rsa_bits" {
  description = "The number of bits in the SSH key to use"
  type        = number
}

# Specifies the name for the EC2 key pair.
variable "key_pair_ec2" {
  description = "The name of the SSH key to use"
  type        = string
}

# Specifies the short name for the environment (e.g., dev, prod).
variable "env_short" {
  description = "The environment short name"
  type        = string
}


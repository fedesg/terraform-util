# Required variables

variable "cognito_user_pool_name" {
    description = "Cognito resource name"
    type = string
}

variable "tags" {
    description = "Resource tags"
    type = map(any)
}
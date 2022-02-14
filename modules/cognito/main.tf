resource "aws_congnito_user_pool" "user_pool" {
    name = "${var.cognito_user_pool_name}"
    tags = "${var.tags}"
}

resource "aws_cognito_user_pool_client" "pool_client" {
    name = "${var.cognito_user_pool_name}_client"
    user_pool_id = aws_cognito_user_pool.user_pool.id
    explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
}
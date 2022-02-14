output "cognito_user_pool_id" {
    value = aws_congnito_user_pool.user_pool.id
}

output "cognito_user_pool_name" {
    value = aws_congnito_user_pool.user_pool.name
}

output "cognito_user_pool_arn" {
    value = aws_congnito_user_pool.user_pool.arn
}

output "cognito_user_pool_client_id" {
    value = aws_cognito_user_pool_client.pool_client.id
}

output "cognito_user_pool_client_name" {
    value = aws_cognito_user_pool_client.pool_client.name
}


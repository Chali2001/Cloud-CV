provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "counter" {
  name         = "cloud-CV-contador"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
resource "aws_lambda_function" "counter" {
  function_name = "cloud-CV-counter"

  handler = "index.lambda_handler"
  runtime = "python3.12"

  filename         = "dummy.zip"
  source_code_hash = "dummy"

  role = "arn:aws:iam::730335345583:role/LabRole"

  lifecycle {
    ignore_changes = [
      filename,
      source_code_hash,
      handler
    ]
  }
}
# HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = "CV-api"
  protocol_type = "HTTP"
  lifecycle {
    ignore_changes = [
      cors_configuration
    ]
  }
}

# Stage prod (auto-deploy)
resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "prod"
  auto_deploy = true
}

# Integración con Lambda
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.counter.invoke_arn
  payload_format_version = "2.0"
}

# Ruta GET /count
resource "aws_apigatewayv2_route" "count" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /count"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Permiso para invocar la Lambda
resource "aws_lambda_permission" "api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.counter.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}
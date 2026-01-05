provider "aws" {
  region = "us-east-1"
}
resource "aws_route53_zone" "cv_zone" {
  name = "cv.chalichen.cat"
}
resource "aws_amplify_app" "cv_app" {
  name       = "cv-frontend"
  repository = "https://github.com/${var.github_repo}.git"

  oauth_token = var.github_token

  enable_auto_branch_creation = false

  build_spec = <<EOF
version: 1
frontend:
  phases:
    build:
      commands:
        - echo "static site"
  artifacts:
    baseDirectory: cv-generated
    files:
      - '**/*'
EOF
}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.cv_app.id
  branch_name = "main"
}
variable "github_repo" {
  description = "Repositorio GitHub del CV"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}
variable "environment" {
  description = "Ambiente para o deploy (staging ou production)"
  type        = string
  default     = "staging"
}

variable "branch" {
  description = ""
  type        = string
  default     = "development"
}
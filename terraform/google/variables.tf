variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "ssh_user" {
  description = "SSH user for the instance"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for the instance"
  type        = string
}

variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "zone" {
  description = "default zone"
  type        = string
  default     = "ru-central1-a"
}

variable "name" {
  description = "default name for instance"
  type        = string
  default     = ""
}

variable "username" {
  description = "default username for instance's user"
  type        = string
  default     = "user1"
}

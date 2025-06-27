variable "vpc_id" {
  type        = string
  description = "VPC ID where SGs will be created"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR for internal access"
}

variable "name" {
  description = "Prefix name for the RDS security group"
  type        = string
}


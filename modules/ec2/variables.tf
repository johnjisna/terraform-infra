variable "image_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "target_group_arns_public" {
  description = "ALB Target Group ARNs for public instances"
  type        = list(string)
}

variable "target_group_arns_private" {
  description = "ALB Target Group ARNs for private instances"
  type        = list(string)
}

variable "ec2_public_sg_id" {
  type = string
}

variable "ec2_private_sg_id" {
  type = string
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where ALB is deployed"
  type        = string
}


variable "alb_sg_id" {
  type        = string
  description = "Security group for ALB"
}

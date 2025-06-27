output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_public_sg_id" {
  value = aws_security_group.ec2_public_sg.id
}

output "ec2_private_sg_id" {
  value = aws_security_group.ec2_private_sg.id
}

output "db_sg_id" {
  description = "Security group ID for RDS"
  value       = aws_security_group.db_sg.id
}


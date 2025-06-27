output "public_asg_name" {
  value = aws_autoscaling_group.public.name
}

output "private_asg_name" {
  value = aws_autoscaling_group.private.name
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn_public" {
  value = aws_lb_target_group.public.arn
}

output "target_group_arn_private" {
  value = aws_lb_target_group.private.arn
}

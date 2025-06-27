output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_asg_name" {
  value = module.ec2.public_asg_name
}

output "private_asg_name" {
  value = module.ec2.private_asg_name
}

output "rds_endpoint" {
  value = module.rds_postgres.rds_endpoint
}

output "rds_connection_string" {
  value     = module.rds_postgres.rds_connection_string
  sensitive = true
}

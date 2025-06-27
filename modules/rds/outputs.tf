output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.postgres_instance.endpoint
}

output "rds_connection_string" {
  description = "PostgreSQL connection string"
  value       = "postgresql://${var.username}:${var.password}@${aws_db_instance.postgres_instance.endpoint}/${var.db_name}"
  sensitive   = true
}

variable "name" {
  description = "Prefix for RDS resources"
  type        = string
  default     = "my-postgres-db"
}

variable "username" {
  description = "Database admin username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
  default     = "changeme123!"
}

variable "db_name" {
  description = "Initial DB name"
  type        = string
  default     = "appdb"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "15.4"
}

variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage in GB"
  type        = number
  default     = 20
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-12345678"
}

variable "sg_id" {
  description = "Security Group ID"
  type        = string
  default     = "sg-12345678"
}

variable "publicly_accessible" {
  description = "Should the DB be publicly accessible?"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot before deletion"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "auto_minor_version_upgrade" {
  description = "Allow automatic minor version upgrades"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "final_snapshot_identifier" {
  description = "Identifier for the final snapshot when deleting RDS"
  type        = string
  default     = "final-snapshot"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS subnet group"
}

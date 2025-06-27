resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids  

  tags = {
    Name = "${var.name}-subnet-group"
  }
}

resource "aws_db_instance" "postgres_instance" {
  identifier             = var.name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  username               = var.username
  password               = var.password
  db_name                = var.db_name

  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name

  publicly_accessible        = var.publicly_accessible
  multi_az                   = var.multi_az
  skip_final_snapshot        = var.skip_final_snapshot
  deletion_protection        = var.deletion_protection
  backup_retention_period    = var.backup_retention_period
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  maintenance_window         = var.maintenance_window
  final_snapshot_identifier  = var.final_snapshot_identifier

  tags = {
    Name = var.name
  }
}

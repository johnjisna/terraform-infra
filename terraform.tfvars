vpc_name            = "my-vpc"
lb_name             = "my-alb"
image_id            = "ami-03e31863b8e1f70a5"
instance_type       = "t2.micro"
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

name                        = "devdb"
username                    = "postgresadmin"
password                    = "Admin12345"
db_name                     = "sampledb"
engine                      = "postgres"
engine_version              = "17.5"
instance_class              = "db.t3.micro"
allocated_storage           = 20

publicly_accessible         = false
multi_az                    = false
skip_final_snapshot         = false
deletion_protection         = false
backup_retention_period     = 7
auto_minor_version_upgrade  = false
maintenance_window          = "Mon:00:00-Mon:03:00"
final_snapshot_identifier = "final-snapshot-devdb"

ecr_repository_name      = "test-ecr-repo"
ecr_scan_on_push         = true
ecr_image_tag_mutability = "IMMUTABLE"
environment              = "dev"
project                  = "test"

secret_name        = "test-dev-secret-version-0"
secret_description = "Database credentials for updated application"
secret_values = {
  username = "postgresadmin"
  password = "Admin12345"
}

acm_certificate_arn = ""
custom_domain_name  = ""
policy_name         = "test-s3-iam-user-policy"
policy_type         = "private_iam"
bucket_name         = "test-dev-bucket"

iam_user_name_backend  = "test-backend-user"
iam_user_name_frontend = "test-frontend-user"
iam_role_name_backend  = "test-backend-role"
iam_role_name_frontend = "test-frontend-role"
iam_role_name          = "test-ecr-read-role"
trusted_services       = ["ec2.amazonaws.com"]

terraform {
  backend "s3" {
    bucket = "terraform-buck123"
    key    = "state"
    region = "us-east-1"
    #dynamodb_table = "backend-db"
    use_lockfile = true
  }
}

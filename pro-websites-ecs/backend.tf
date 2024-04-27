# Terraform block settings & backend to store my state file in s3 bucket
terraform {
  backend "s3" {
    bucket = "promgrafana"
    key    = "prometheus/terramodules.tfstate"
    region = "us-east-1"
  }
}
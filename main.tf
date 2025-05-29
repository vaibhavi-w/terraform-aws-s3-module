provider "aws" {
  region = "eu-west-1"
}

module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "vaibhavi-bucket-<date>"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

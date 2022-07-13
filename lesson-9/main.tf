provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_vpcs" "my_vpcs" {}

data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "prod"
  }
}



output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region" {
  value = data.aws_region.current.name
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}

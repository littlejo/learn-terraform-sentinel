provider "aws" {
  region = var.region
}

resource "aws_instance" "ubuntu" {
  ami                    = "ami-0ebfd941bbafe70c6"
  instance_type          = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "aaa"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = [for k, v in ["us-east-1a", "us-east-1b"] : cidrsubnet("10.0.0.0/16", 4, k)]

  tags = local.tags
}

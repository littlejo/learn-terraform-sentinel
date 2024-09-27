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
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

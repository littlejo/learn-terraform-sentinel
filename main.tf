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

terraform {
  required_version = ">= 0.12"

  backend "local" {
    organization = "local"

    workspaces {
      name = "foundations"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}



data "aws_ami" "latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type
}

output "ami_id" {
  value = data.aws_ami.latest.id
}

output "ami_name" {
  value = data.aws_ami.latest.name
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0b752bf1df193a6c4"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0818b9561675ff47e"
  vpc_security_group_ids = ["sg-003af02b9a759e866"]
  key_name               = "clave-lucatic"
  user_data = <<EOF
  #!/bin/sh
amazon-linux-extras install -y docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user
pip3 install docker-compose
wget <https://raw.githubusercontent.com/2000GHz/hello-2048/master/docker-compose.yaml>
docker-compose pull
docker-compose up -d
EOF

  tags = {
    Name = var.instance_name
    APP  = var.app_name
  }
}
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

  tags = {
    Name = var.instance_name
    APP  = var.app_name
  }

  provisioner "file" {
    source = "cloudinit.sh"
    destination = "/tmp/cloudinit.sh"
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloudinit.sh",
      "sudo /tmp/cloudinit.sh"
    ]
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
    }
  }

}

 

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "cloudflare" {
}

resource "aws_instance" "hello" {
  ami = "ami-0f9c27b471bdcd702"
  instance_type = "t2.micro"
  subnet_id = "subnet-971127ce"

  key_name = "Amazon1"

  tags = {
    Name = "Hello"
  }
}

resource "cloudflare_dns_record" "hello" {
  zone_id = "0c22c66db4cba546fd69ca24a4ba70c7"
  name = "test.hpc-carpentry.cloud"
  content = aws_instance.hello.public_ip
  ttl = 3600 
  type = "A"
  proxied = false
}

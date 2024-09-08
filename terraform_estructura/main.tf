provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = "10.0.0.0/16"
  vpc_name           = "my-vpc"
  subnet_cidr        = "10.0.1.0/24"
  availability_zone  = "us-east-1a"
}

module "ec2_instance" {
  source = "./modules/ec2"

  instance_name = "MundosE_PIN_Final"
  ami_id        = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

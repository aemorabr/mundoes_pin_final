provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  vpc_name           = "mundose-vpc"
  subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "ec2_instance" {
  source = "./modules/ec2"

  instance_name = "MundosE_PIN_Final"
  ami_id        = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id    = module.vpc.public_subnet_ids[0]
  vpc_id= module.vpc.vpc_id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

module "eks_cluster" {
  source = "./modules/eks"

  cluster_name      = "eks-mundos-e"
  subnet_ids   = module.vpc.public_subnet_ids
  node_group_name   = "eks-mundos-e-node-group"
  node_desired_size = 3
  node_max_size     = 3
  node_min_size     = 1
  instance_types    = ["t3.small"]
  ssh_key_name      = module.ec2_instance.key_name
  role_arn          = module.ec2_instance.role_arn
  depends_on = [module.ec2_instance,module.ec2_instance.aws_key_pair ]
}
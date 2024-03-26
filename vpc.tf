provider "aws" {
	region = ""
	access_key = ""
	secret_key = ""
}

variable "vpc_cidr" {}
variable "private_subnets" {}
variable "public_subnets" {}

data "aws_availability_zones" "azs" {}

module "dev_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"

  name = "dev_vpc"
  cidr = var.vpc_cidr
  azs = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  tags = {
  	"kubernetes.io/cluster/devapp-eks-cluster" = "shared"
  }

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  private_subnet_tags = {
  	"kubernetes.io/cluster/devapp-eks-cluster" = "shared"
  	"kubernetes.io/role/internal-elb" = 1
  }

  public_subnet_tags = {
  	"kubernetes.io/cluster/devapp-eks-cluster" = "shared"
  	"kubernetes.io/role/elb" = 1
  }
}
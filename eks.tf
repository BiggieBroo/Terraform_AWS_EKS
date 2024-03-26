provider "kubernetes" {
  host = data.aws_eks_cluster.cluster_app.endpoint
  token = data.aws_eks_cluster_auth.cluster_app.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_app.certificate_authority.0.data)
}

data "aws_eks_cluster" "cluster_app" {
  name = module.dev_eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster_app" {
  name = module.dev_eks.cluster_id
}

module "dev_eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.24.0"

  cluster_name = "dev_eks"
  cluster_version = "1.29"

  subnets = module.dev_vpc.private_subnets
  vpc_id = module.dev_vpc.vpc_id

  worker_groups = [

    {
      name = "dev_instance"
      instance_type = "t2.micro"
      asg_desired_capacity = 2      
    }

  ]
}
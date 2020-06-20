data "aws_eks_cluster" "cluster" {
  name = module.eks01.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks01.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "eks01" {
  source          = "github.com/terraform-aws-modules/terraform-aws-eks?ref=v12.1.0"
  cluster_name    = "eks01"
  cluster_version = "1.16"
  subnets         = module.vpc.private_subnets

  tags = {
    managed_by  = "terraform"
    environment = module.stage.name
  }

  vpc_id = module.vpc.vpc_id

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 5
    }
  ]
}
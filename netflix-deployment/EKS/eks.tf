module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  cluster_name = local.name
  #   cluster_version = "1.31"

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  # Optional
  cluster_endpoint_public_access = true


  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  #   control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  # EKS Managed Node Group(s)
  #   eks_managed_node_group_defaults = {
  #     instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  #   }

  eks_managed_node_groups = {
    abhi-cluster = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      capacity_type  = "SPOT"
      instance_types = ["t2.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      tags = {
        ExtraTag = "Hello DevOps"
      }
    }
  }
  tags = local.tags

}
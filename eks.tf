module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.20.0"

  cluster_name    = "${local.name}-eks"
  cluster_version = "1.30"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    system = {
      instance_types = ["m5.large"]
      
      min_size = 2
      max_size = 4
      desired_size = 2

      labels = {
        nodegroup = "system"
      }

      taints = [
        {
           key    = "CriticalAddonsOnly"
           value  = "system"
           effect = "NO_SCHEDULE"
        }
      ]
      
      tags = {
        nodegroup = "system"
      }
    }
    workloads = {
      instance_types = ["m5.large"]
      
      min_size = 0
      max_size = 10
      desired_size = 0

      labels = {
        nodegroup = "workloads"
      }

      taints = [
        {
           key    = "type",
           value  = "workloads"
           effect = "NO_SCHEDULE"
        }
      ]
      
      tags = {
        nodegroup = "workloads"
      }
    }
  }

  tags = local.tags
}
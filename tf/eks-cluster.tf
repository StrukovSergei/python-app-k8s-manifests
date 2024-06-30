module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.30"

  vpc_id     = module.vpc.vpc_id
  # subnet_ids = module.vpc.private_subnets
  subnet_ids = module.vpc.public_subnets
  cluster_endpoint_public_access = true

  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  # cluster_endpoint_public_access_cidrs = ["89.139.19.130/32", "109.253.167.9/32", "213.57.121.34/32"]

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["t2.micro"]
      min_size     = 8
      max_size     = 15  
      desired_size = 10
      additional_security_group_ids = [aws_security_group.custom_sg.id]

    }

#    two = {
 #     name = "node-group-2"
 #     instance_types = ["t2.micro"]
 #     min_size     = 5
 #     max_size     = 15  
  #    desired_size = 8
 #     additional_security_group_ids = [aws_security_group.custom_sg.id]
#
 #   }
#    three = {
 #     name = "node-group-3"
 #     instance_types = ["t2.micro"]
  #    min_size     = 10
  #    max_size     = 15  
   #   desired_size = 10
   #   additional_security_group_ids = [aws_security_group.custom_sg.id]

 #   }
  }
}

resource "aws_security_group" "custom_sg" {
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]  
  }
}

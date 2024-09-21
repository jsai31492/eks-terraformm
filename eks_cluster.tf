resource "aws_eks_cluster" "eks_cluster" {
  name = "my-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_subnet[*].id
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-node-group"
  node_role_arn = aws_iam_role.eks_node_role.arn
  subnet_ids = aws_subnet.eks_subnet[*].id

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }

  instance_types = ["t3.medium"]

  remote_access {
    ec2_ssh_key = "sairam"
  }

  tags = {
    Name = "eks-node-group"
  }
}

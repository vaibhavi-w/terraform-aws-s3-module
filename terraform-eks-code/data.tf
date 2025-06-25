data "aws_availability_zones" "available" {
    state = "available"
}

data "aws_iam_role" "eks_cluster_role" {
    name = "eksClusterRole"
}

data "aws_iam_role" "eks_node_role" {
    name = "eks-node-role"
}


resource "aws_route_table" "main" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "main-rt"
    }
}

resource "aws_security_group" "main" {
    name        = "main-sg"
    description = "Allow SSH and HTTP"
    vpc_id      = aws_vpc.main.id

    dynamic "ingress" {
        for_each = [
            {
                from_port   = 22
                to_port     = 22
                protocol    = "tcp"
                cidr_blocks = ["223.186.153.90/32"]
            },
            {
                from_port   = 80
                to_port     = 80
                protocol    = "tcp"
                cidr_blocks = ["10.1.0.0/16"]
            }
        ]
        content {
            from_port   = ingress.value.from_port
            to_port     = ingress.value.to_port
            protocol    = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "main-sg"
    }
}

resource "aws_route_table_association" "main_1" {
    subnet_id      = aws_subnet.main[0].id
    route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "main_2" {
    subnet_id      = aws_subnet.main[1].id
    route_table_id = aws_route_table.main.id
}
// ...existing code...

resource "aws_eks_cluster" "main" {
  name     = "main-eks-cluster"
  role_arn = data.aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.main[0].id, aws_subnet.main[1].id]
    security_group_ids = [aws_security_group.main.id]
  }

  depends_on = [aws_security_group.main]
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "main-eks-node-group"
  node_role_arn   = data.aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.main[0].id, aws_subnet.main[1].id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  depends_on = [aws_eks_cluster.main]
}
// ...existing code...

resource "aws_eks_node_group" "main_extra" {
    cluster_name    = aws_eks_cluster.main.name
    node_group_name = "main-eks-node-group-extra"
    node_role_arn   = data.aws_iam_role.eks_node_role.arn
    subnet_ids      = [aws_subnet.main[0].id, aws_subnet.main[1].id]
    capacity_type   = "ON_DEMAND"

    scaling_config {
        desired_size = 1
        max_size     = 1
        min_size     = 1
    }

    instance_types = ["t3.large"]

    disk_size = 20

    remote_access {
       
        ec2_ssh_key = "Neeharika_Terraform"
    }

    depends_on = [aws_eks_cluster.main]
}
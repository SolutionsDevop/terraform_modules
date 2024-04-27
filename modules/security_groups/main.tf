# This module is to create a security group, you can modify to fit 
# your needs (ec3 instances, containers, loadbalancers..etc)
resource "aws_security_group" "server_alb_sg" {
  name = "server security group or loadbalancer security group"
  description = "Allow all the traffic listed below"
  vpc_id = var.vpc_id

  ingress {
    description = "https access"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "server_alb-sg"
  }
}

# This resource will create security groups for containers
resource "aws_security_group" "ecs_security_group" {
  name = "elastic container service securty group"
  description = "Allow web access on give ports via server_alb-sg"
  vpc_id = var.vpc_id
  ingress {
    description = "http access"
    from_port = 80
    to_port = 80
    protocol ="tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-sg"
  }
}
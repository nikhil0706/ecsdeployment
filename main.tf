provider "aws" {
  region = "us-east-1"
}

# Retrieve existing ECS cluster
data "aws_ecs_cluster" "existing" {
  cluster_name = "my-app-cluster"  # Update with your cluster name
}

# Retrieve existing ECR repository
data "aws_ecr_repository" "app_repo" {
  name = "my-app"  # Update with your repository name
}

# IAM Role for Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app_task" {
  family                   = "my-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "app-container"
      image     = "${data.aws_ecr_repository.app_repo.repository_url}:latest"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
    }
  ])
}

# Retrieve existing VPC & subnets
data "aws_vpc" "existing" {
  id = "vpc-xxxxxxxx" # Update with your VPC ID
}

data "aws_subnets" "existing" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}

# Security Group
resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  vpc_id      = data.aws_vpc.existing.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ECS Service
resource "aws_ecs_service" "app_service" {
  name            = "my-app-service"
  cluster         = data.aws_ecs_cluster.existing.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.existing.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  desired_count = 2
}

data "aws_lb" "existing_lb" {
  name = "app-lb"
}

output "load_balancer_url" {
  value = data.aws_lb.existing_lb.dns_name
}

data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:ecs-vpc"
    values = ["main"]
  }
}

output "vpc_id" {
  value = data.aws_vpc.existing_vpc.id
}


# Fetch Subnet IDs using the VPC ID and Subnet Names
data "aws_subnets" "existing_subnets" {
  filter {
    name   = "vpc_id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}

data "aws_subnet" "subnet_1" {
  filter {
    name   = "tag:ecs-subnet1"
    values = ["ecs_subnet_1"]  # Replace with Subnet Name
  }
}

data "aws_subnet" "subnet_2" {
  filter {
    name   = "tag:ecs-subnet2"
    values = ["ecs_subnet_1"]  # Replace with Subnet Name
  }
}

# Output subnet IDs
output "subnet_1_id" {
  value = data.aws_subnet.subnet_1.id
}

output "subnet_2_id" {
  value = data.aws_subnet.subnet_2.id
}



data "aws_security_group" "existing_sg" {
  filter {
    name   = "tag:Name"
    values = ["ecs_secgrp"]
  }
}

output "security_group_id" {
  value = data.aws_security_group.existing_sg.id
}



data "aws_ecs_cluster" "existing_cluster" {
  cluster_name = "ecs_cluster"
}

output "ecs_cluster_id" {
  value = data.aws_ecs_cluster.existing_cluster.id
}


data "aws_ecs_task_definition" "existing_task" {
  task_definition = "app_task" 
#task family name
}

output "ecs_task_definition_arn" {
  value = data.aws_ecs_task_definition.existing_task.arn
}

data "aws_lb_target_group" "existing_tg" {
  target_group = "app-tg" 
}

output "aws_lb_target_group" {
  value = data.aws_lb_target_group.existing_tg.arn
}

data "aws_ecr_repository" "app_repo" {
  name = var.ecr_repository_name
}


data "aws_ecr_image" "latest_image" {
  repository_name = var.ecr_repository_name
  most_recent     = true
}




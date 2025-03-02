data "aws_lb" "existing_lb" {
  name = "your-existing-lb-name"
}

output "load_balancer_url" {
  value = data.aws_lb.existing_lb.dns_name
}

data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["your-vpc-name"]
  }
}

output "vpc_id" {
  value = data.aws_vpc.existing.id
}


data "aws_subnets" "existing_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}

output "subnet_ids" {
  value = data.aws_subnets.existing_subnets.ids
}



data "aws_security_group" "existing_sg" {
  filter {
    name   = "tag:Name"
    values = ["your-security-group-name"]
  }
}

output "security_group_id" {
  value = data.aws_security_group.existing_sg.id
}

data "aws_ecs_cluster" "existing_cluster" {
  cluster_name = "your-existing-cluster-name"
}

output "ecs_cluster_id" {
  value = data.aws_ecs_cluster.existing_cluster.id
}


data "aws_ecs_task_definition" "existing_task" {
  task_definition = "your-task-family-name"
}

output "ecs_task_definition_arn" {
  value = data.aws_ecs_task_definition.existing_task.arn
}

data "aws_ecr_repository" "app_repo" {
  name = var.ecr_repository_name
}


data "aws_ecr_image" "latest_image" {
  repository_name = var.ecr_repository_name
  most_recent     = true
}


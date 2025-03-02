variable "aws_region" {
  default = "us-east-2"
}

variable "ecs_cluster_name" {
  default = "my-app-cluster"
}

variable "ecs_service_name" {
  default = "my-app-service"
}

###############

#variable "ecr_repository_name" {
#  description = "The name of the existing ECR repository"
#  type        = string
#}

################

#variable "cpu" {
#  default = "512"
#}

#variable "memory" {
#  default = "1024"
#}

#variable "container_port" {
#  default = 80
#}

#variable "vpc_id" {
#  description = "VPC ID where ECS will be deployed"
#}

#variable "subnet_ids" {
#  description = "List of subnets for ECS tasks"
#  type        = list(string)
#}

#variable "task_family_name" {
#  description = "The family name of the ECS task definition"
#  type        = string
#}


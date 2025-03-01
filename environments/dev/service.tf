# Security Group
#resource "aws_security_group" "ecs_sg" {
#  name        = "ecs-sg"
#  vpc_id      = var.vpc_id

#  ingress {
#    from_port   = var.container_port
#    to_port     = var.container_port
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }

#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

# ECS Service
resource "aws_ecs_service" "app_service" {
  name            = var.ecs_service_name
  cluster         = data.aws_ecs_cluster.existing.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  desired_count = 2
}




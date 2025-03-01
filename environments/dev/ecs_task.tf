resource "aws_ecs_task_definition" "app_task" {
  family                   = var.task_family_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "my-app-container"
      image     = data.aws_ecr_image.latest_image.image_uri
      memory    = 512
      cpu       = 256
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    }
  ])
}


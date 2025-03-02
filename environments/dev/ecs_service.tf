#resource "aws_ecs_service" "app_service" {
#  name            = "my-app-service"
#  cluster         = data.aws_ecs_cluster.existing_cluster.id
#  task_definition = aws_ecs_task_definition.app_task.arn
#  launch_type     = "FARGATE"

#  network_configuration {
#    subnets          = data.aws_subnets.existing_subnets.ids
#    security_groups  = [data.aws_security_group.existing_sg.id]
#    assign_public_ip = true
#  }

#  desired_count = 2
#}


#resource "aws_iam_role" "ecs_execution_role" {
#  name = "ecsExecutionRole"

#  assume_role_policy = jsonencode({
#    Statement = [{
#      Action = "sts:AssumeRole"
#      Effect = "Allow"
#      Principal = {
#        Service = "ecs-tasks.amazonaws.com"
#      }
#    }]
#  })
#}

#resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
#  role       = aws_iam_role.ecs_execution_role.name
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#}


#retrieving the latest image from ECR 
data "aws_ecr_repository" "app_repo" {
  name = var.ecr_repository_name
}

data "aws_ecr_image" "latest_image" {
  repository_name = var.ecr_repository_name
  most_recent     = true
}

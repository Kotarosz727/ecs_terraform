resource "aws_ecr_repository" "laravel-back-end" {
  name                 = "laravel-back-end"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "next-front-end" {
  name                 = "next-front-end"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "nginx" {
  name                 = "nginx"

  image_scanning_configuration {
    scan_on_push = true
  }
}
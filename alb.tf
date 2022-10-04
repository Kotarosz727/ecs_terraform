resource "aws_lb_target_group" "main" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_security_group" "app-sg" {
  name        = "app-sg"
  description = "app-sg"
  vpc_id      = aws_vpc.main.id

  //HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    #protocol    = "-1" は "all" と同等
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "20221006-app-sg"
  }

}

resource "aws_lb" "main" {
  name = "${local.app_name}-integrated-alb"
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.app-sg.id
  ]

  subnets = [
    aws_subnet.public.*.id,
  ]
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.main.arn
#   port = 443
#   protocol = "HTTPS"

#   default_action {
#     type = "fixed-response"
#     fixed_response {
#       content_type = "text/plain"
#       message_body = "503 Service Temporarily Unavailable"
#       status_code = "503"
#     }
#   }
# }
resource "aws_lb" "auto-load-balancer-frontend" {
  name               = "auto-load-balancer-frontend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [
    aws_security_group.public_alb_security_group.id,
    aws_security_group.allow-ssh.id
  ]

  subnets = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]

  enable_deletion_protection = false

  tags = {
    Name        = "auto-load-balancer-frontend"
    Environment = "production"
  }

  depends_on = [aws_lb.auto-load-balancer-backend]

}

resource "aws_lb_listener" "http2" {
  load_balancer_arn = aws_lb.auto-load-balancer-frontend.arn
  port              = 80

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "There's nothing here"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "my_app2" {
  listener_arn = aws_lb_listener.http2.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.load-balancer-target-group2.arn
  }

  condition {
    host_header {
      values = ["myapp.example.com"]
    }
  }

}

resource "aws_lb_target_group" "load-balancer-target-group2" {
  vpc_id   = aws_vpc.production-vpc.id
  name     = "target-group-frontend"
  port     = 80
  protocol = "HTTP"
}
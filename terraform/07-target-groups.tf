resource "aws_lb_target_group" "load-balancer-target-group1" {
  vpc_id   = aws_vpc.production-vpc.id
  name     = "target-group-backend"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/status"
  }
}

resource "aws_lb_target_group" "load-balancer-target-group2" {
  vpc_id   = aws_vpc.production-vpc.id
  name     = "target-group-frontend"
  port     = 80
  protocol = "HTTP"
  health_check {
    path = "/status"
  }
}


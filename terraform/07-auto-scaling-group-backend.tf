resource "aws_autoscaling_group" "autoscaling-group-backend" {
  name = "autoscaling-group-backend-app"

  vpc_zone_identifier = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  desired_capacity    = 2
  max_size            = 10
  min_size            = 2

  target_group_arns = [
    aws_lb_target_group.load-balancer-target-group1.arn
  ]

  health_check_grace_period = 60

  protect_from_scale_in = false

  launch_template {
    id      = aws_launch_template.launch-backend.id
    version = "$Latest"
  }

  tag {
    key                 = "scaling-group"
    propagate_at_launch = true
    value               = "auto-scaling-app"
  }

  depends_on = ["aws_lb_target_group.load-balancer-target-group1"]

}

resource "aws_autoscaling_policy" "scale_app1" {
  name        = "requests_count_scaling_policy1"
  policy_type = "TargetTrackingScaling"

  autoscaling_group_name = aws_autoscaling_group.autoscaling-group-backend.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = format("%s/%s", aws_lb.auto-load-balancer-backend.arn_suffix, aws_lb_target_group.load-balancer-target-group1.arn_suffix)
    }

    target_value = 30
  }

  depends_on = ["aws_lb_target_group.load-balancer-target-group1"]

}

# Scale up

resource "aws_appautoscaling_policy" "ecs-scaleup" {
  name               = "${module.variables.project_name_env}-ecs-scaleup"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu-scaleup-ecs" {
  alarm_name          = "${module.variables.project_name_env}-cpu-scaleup-ecs"
  alarm_description   = "This metric monitors ec2 CPU utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    "AutoScalingGroupName" = module.ecs_cluster.autoscaling_group_name
  }

  actions_enabled = true
  alarm_actions   = [aws_appautoscaling_policy.ecs-scaleup.arn]
}

# Scale down

resource "aws_appautoscaling_policy" "ecs-scaledown" {
  name               = "${module.variables.project_name_env}-ecs-scaledown"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu-scaledown-ecs" {
  alarm_name          = "${module.variables.project_name_env}-cpu-scaledown-ecs"
  alarm_description   = "This metric monitors ec2 CPU utilization"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = module.ecs_cluster.autoscaling_group_name
  }

  actions_enabled = true
  alarm_actions   = [aws_appautoscaling_policy.ecs-scaledown.arn]
}

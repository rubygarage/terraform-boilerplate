resource "aws_appautoscaling_target" "ecs_target" {
  min_capacity       = module.variables.min_task_count
  max_capacity       = module.variables.max_task_count
  resource_id        = "service/${module.ecs_cluster.cluster.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

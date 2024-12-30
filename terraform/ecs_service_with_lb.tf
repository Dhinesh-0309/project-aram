
resource "aws_ecs_service" "ecs_service_with_lb" {
  name            = "aram-service-lb"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.aram_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_b.id]  # Use both subnets
    security_groups = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = "ARAM-container"
    container_port   = 5000
  }
}

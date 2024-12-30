
resource "aws_ecs_service" "ecs_service" {
  name            = "aram-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.aram_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_b.id]  # Use both subnets in different AZs
    security_groups = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }
}


resource "aws_ecs_task_definition" "aram_task" {
  family                   = "aram-task"
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = jsonencode([
    {
      name      = "ARAM-container",
      image     = "dhineshpandian/project-aram:latest",
      cpu       = 256,
      memory    = 512,
      essential = true,
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::253490762538:role/ecsTaskExecutionRole"
}

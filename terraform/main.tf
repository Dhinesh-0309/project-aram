provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ARAM-app-cluster"
}

resource "aws_ecs_task_definition" "aram_task" {
  family                   = "aram-task"
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
  execution_role_arn       = "arn:aws:iam::your-account-id:role/ecsTaskExecutionRole"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "aram-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.aram_task.arn
  desired_count   = 1

  launch_type     = "FARGATE"
  network_configuration {
    subnets         = ["subnet-id"]
    security_groups = ["sg-id"]
  }
}

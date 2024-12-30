
resource "aws_security_group" "ecs_security_group" {
  name        = "ecs-sg"
  description = "Allow inbound HTTP traffic to ECS container"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

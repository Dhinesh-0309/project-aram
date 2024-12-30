
resource "aws_lb" "ecs_lb" {
  name               = "ecs-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_security_group.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_b.id]  
}


resource "aws_lb_target_group" "ecs_target_group" {
  name         = "ecs-target-group"
  port         = 5000
  protocol     = "HTTP"
  vpc_id       = aws_vpc.main_vpc.id
  target_type  = "ip"  
}


resource "aws_lb_listener" "ecs_lb_listener" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    type             = "forward"
  }
}

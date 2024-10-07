resource "aws_lb" "application_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}

resource "aws_lb_target_group" "asg_tg" {
  name     = "asg-target-group"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.main_vpc.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_tg.arn
  }
}
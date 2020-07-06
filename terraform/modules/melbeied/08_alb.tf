resource "aws_alb" "alb" {
  name = "mainALB"
  load_balancer_type = "application"
  subnets = aws_subnet.public.*.id
  security_groups = [
    aws_security_group.alb-sg.id,
  ]
  #enable_deletion_protection = true
  ip_address_type = "ipv4"
}

resource "aws_alb_target_group" "alb_tg_front" {
  name     = "front-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.melbeied.id
  stickiness {
    type = "lb_cookie"
  }
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
    matcher             = "200,302"
  }
}



resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.alb_tg_front, ]
  default_action {
    target_group_arn = aws_alb_target_group.alb_tg_front.arn
    type             = "forward"
  }
}
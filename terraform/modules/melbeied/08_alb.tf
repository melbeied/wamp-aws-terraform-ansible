resource "aws_alb" "alb" {
  name = "mainALB"
  subnets = aws_subnet.public.*.id
  security_groups = [
    "${aws_security_group.public_alb_sg.id}",
  ]
}

resource "aws_alb_target_group" "tg" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.melbeied.id
  stickiness {
    type = "lb_cookie"
  }
  
  health_check {
    path = "/"
    port = 80
    protocol = "HTTP"
    
    // healthy_threshold = "3"
    // interval = "30"
    // matcher = "200"
    // timeout = "5"
    // unhealthy_threshold = "3"
  }

}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.tg]
  default_action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"
  }
}

resource "aws_alb_listener" "listner_https" {
    load_balancer_arn = aws_alb.alb.arn
    port              = "443"
    protocol          = "HTTPS"
    depends_on        = [aws_alb_target_group.tg]
    certificate_arn   = aws_acm_certificate.cert.arn
    default_action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"
    }
}

resource "aws_lb_listener_certificate" "ssl_cert" {
    depends_on          = [ aws_acm_certificate.cert, ]
    listener_arn        = aws_alb_listener.listner_https.arn
    //certificate_arn = "arn:aws:acm:us-east-1:00012345678:certificate/abcd-abcd-abcd-1234-abcd"
    certificate_arn     = aws_acm_certificate.cert.arn
}
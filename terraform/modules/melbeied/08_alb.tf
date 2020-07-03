resource "aws_alb" "alb" {
  name = "mainALB"
  load_balancer_type = "application"
  subnets = aws_subnet.public.*.id
  security_groups = [
    aws_security_group.alb.id,
  ]
  #enable_deletion_protection = true
  ip_address_type = "ipv4"
}

resource "aws_alb_target_group" "alb_tg_front" {
  name     = "alb-front-tg"
  vpc_id   = aws_vpc.melbeied.id
  port     = 80
  protocol = "HTTP"
  stickiness {
    type = "lb_cookie"
  }
  health_check {
    matcher = "200,302"
    path = "/"
    port = 80
    interval = 20
    timeout = 5
    healthy_threshold = 4
    unhealthy_threshold = 2
  }
}
resource "aws_alb_target_group_attachment" "alb_front_1" {
  count            = local.       
  target_group_arn = "${aws_alb_target_group.alb_front.arn}"
  target_id        = "${aws_instance.wordpress_1.id}"
  port             = 80
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

// resource "aws_alb_listener" "listner_https" {
// 	load_balancer_arn	=	"${aws_alb.alb_front.arn}"
// 	port			=	"443"
// 	protocol		=	"HTTPS"
// 	ssl_policy		=	"ELBSecurityPolicy-2016-08"
// 	certificate_arn		=	"${aws_iam_server_certificate.url1_valouille_fr.arn}"

// 	default_action {
// 		target_group_arn	=	"${aws_alb_target_group.alb_front_https.arn}"
// 		type			=	"forward"
// 	}
// }

// resource "aws_alb_listener" "listner_https" {
//     load_balancer_arn = aws_alb.alb.arn
//     port              = "443"
//     protocol          = "HTTPS"
//     depends_on        = [aws_alb_target_group.tg]
//     certificate_arn   = aws_acm_certificate.cert.arn
//     default_action {
//     target_group_arn = aws_alb_target_group.tg.arn
//     type             = "forward"
//     }
// }

// resource "aws_lb_listener_certificate" "ssl_cert" {
//     depends_on          = [ aws_acm_certificate.cert, ]
//     listener_arn        = aws_alb_listener.listner_https.arn
//     //certificate_arn = "arn:aws:acm:us-east-1:00012345678:certificate/abcd-abcd-abcd-1234-abcd"
//     certificate_arn     = aws_acm_certificate.cert.arn
// }
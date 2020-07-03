resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow HTTP"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "${local.Project}"
  }
}

resource "aws_alb_target_group" "alb_front" {
  name     = "front-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc.id}"
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
    matcher             = "302,200"
  }
}


resource "aws_alb" "alb_front" {
  name               = "front-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb-sg.id}"]
  subnets            = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]
  tags = {
    Project = "${local.Project}"
  }
}

resource "aws_alb_listener" "alb_front" {
  load_balancer_arn = "${aws_alb.alb_front.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_front.arn}"
  }
}
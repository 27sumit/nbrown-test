# ALB for the web servers
resource "aws_lb" "web_servers" {
  name               = format("%s-alb", var.environment)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.default-dev.id]
  subnets            = aws_subnet.public_subnet.*.id
  enable_http2       = false
  enable_deletion_protection = true
  depends_on  = [aws_subnet.public_subnet, aws_vpc.vpc]

  tags = {
    Name = format("%s-alb", var.environment)
  }
}

# Target group for the web servers
resource "aws_lb_target_group" "web_servers" {
  name     = "nbrown-web-servers-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  depends_on  = [aws_lb.web_servers]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_servers.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_servers.arn
  }
}

# Attach ec2 instances on private subnets to the target group on port 80
resource "aws_lb_target_group_attachment" "web_tga" {
  target_group_arn = aws_lb_target_group.web_servers.arn
  count = length(var.az)
  #target_id        = aws_instance.web.*.id
  #target_id        = [for i in length(var.az) : aws_instance.web.id[count.index]]
  target_id        = element(aws_instance.web.*.id, count.index)
  port             = 80
}

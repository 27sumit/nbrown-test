resource "aws_instance" "web" {
  ami           = var.ami_id 
  instance_type = var.instance_type 
  count = length(var.az) 
  key_name = var.sj_key_pair
  depends_on  = [aws_nat_gateway.nat, aws_subnet.private_subnet, aws_security_group.allow_http]
  security_groups = [aws_security_group.allow_http.id]
  #would need to use vpc_security_group_ids else ec2 gets recreated with each apply.
  user_data =  file("install_http.sh")
  subnet_id     = element(aws_subnet.private_subnet.*.id, count.index)
  tags = {
    Name = "ec2-${var.az[count.index]}-${count.index}"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "web_traffic"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

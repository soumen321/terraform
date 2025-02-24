provider "aws" {
  region = "us-east-1" # Change as needed
}

resource "aws_launch_template" "my_template" {
  name          = "my-clip-template"
  image_id      = "ami-05b10e08d247fb927"  # Change to your AMI
  instance_type = "t2.micro"
  
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.my_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG-Instance"
    }
  }
}

resource "aws_security_group" "my_sg" {
  name_prefix = "asg-sg-"

  ingress {
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
}

resource "aws_autoscaling_group" "my_asg" {
  desired_capacity     = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = ["subnet-0a55a664b8f268eb4", "subnet-02672eccd41691f99"] # Replace with your subnet IDs

  launch_template {
    id      = aws_launch_template.my_template.id
    version = "$Latest"
  }
  
  target_group_arns = [aws_lb_target_group.my_tg.arn]
}

resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets           = ["subnet-0a55a664b8f268eb4", "subnet-02672eccd41691f99"] # Replace with your subnets
}

resource "aws_lb_target_group" "my_tg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0e5e6c161660cc247" # Replace with your VPC ID
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}

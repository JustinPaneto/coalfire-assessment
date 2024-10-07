resource "aws_launch_configuration" "asg_lc" {
  name          = "ASGLaunchConfig"
  image_id      = var.ami
  instance_type = var.instance_type
  ebs_block_device {
    volume_size = 20
    device_name = "/dev/sdh"   # Specify a device name
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              EOF
}

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
  launch_configuration = aws_launch_configuration.asg_lc.id
  min_size             = 2
  max_size             = 6
  desired_capacity     = 2
#   tags = [{
#     key                 = "Name"
#     value               = "ASGInstance"
#     propagate_at_launch = true
#   }]
}
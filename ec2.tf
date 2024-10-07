
resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet2.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name = var.key_name
  
  ebs_block_device {
    device_name = "/dev/sdh"   # Specify a device name
    volume_size = 20
  }

  tags = {
    Name = "EC2InstanceInSubnet2"
  }
}
# EC2 Instances
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.bastion_instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y htop wget curl
              EOF

  tags = {
    Name        = "${var.project_name}-bastion-host"
    Environment = var.environment
    Type        = "Bastion"
    OS          = "Amazon Linux 2"
  }
}

resource "aws_instance" "private" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.private_instance_type
  subnet_id              = aws_subnet.private.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y htop wget curl
              EOF

  tags = {
    Name        = "${var.project_name}-private-instance"
    Environment = var.environment
    Type        = "Private"
    OS          = "Amazon Linux 2"
  }
}
# Security Groups
# Bastion host security group
resource "aws_security_group" "bastion_sg" {
  name        = "${var.project_name}-bastion-sg"
  vpc_id      = aws_vpc.main.id
  description = "Allow SSH from specified CIDR blocks"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-bastion-sg"
    Environment = var.environment
  }
}

# Private instance security group
resource "aws_security_group" "private_sg" {
  name        = "${var.project_name}-private-sg"
  vpc_id      = aws_vpc.main.id
  description = "Allow SSH from Bastion"

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-private-sg"
    Environment = var.environment
  }
}
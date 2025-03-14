provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# Create a new Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow SSH and HTTP"

  # Allow SSH from anywhere (update to restrict access)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define the EC2 instance
resource "aws_instance" "web" {
  ami                    = "ami-00537d8de1b59139e"  # Example Amazon Linux 2 AMI (Change for your region)
  instance_type          = "t2.micro"
  key_name               = "my-key-pair"  # Replace with your existing key pair
  security_groups        = [aws_security_group.web_sg.name]

  tags = {
    Name = "Terraform-EC2"
  }
}

# Output the Public IP
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "unique" {
  byte_length = 8
}

resource "aws_security_group" "eks_sg" {
  name        = "eks_sg_${random_id.unique.hex}"  # Append random ID to make the name unique
  description = "Allow SSH, HTTP, and HTTPS"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "k8s_instance" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  key_name      = "flask-app"

  security_groups = [aws_security_group.eks_sg.name]

  tags = {
    Name = "Kubernetes-EC2"
  }
}

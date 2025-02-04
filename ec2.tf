# resource "aws_instance" "vm" {  
#          ami           = "ami-0c614dee691cbbf37"  
#          availability_zone = "us-east-1a"
#           instance_type = "t2.micro"   
          
#       tags = {     
#            Name = "instance"  
#           } 
# }
# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_instance" "web" {
  ami           = "ami-0c614dee691cbbf37"  
  instance_type = "t2.micro"  
  availability_zone = "us-east-1a"
  key_name      = "nagu-key"  
  #subnet_id     = aws_subnet.my_subnet.id  

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "ec2-instance"
  }
}

# ✅ Security Group to Allow SSH (Port 22) & UI Access (Port 80, 443)
resource "aws_security_group" "web_sg" {
  name        = "web-instance-sg"
  description = "Allow SSH & HTTP/S access"
  

  # Allow SSH (Port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change to your IP for security
  }

  # Allow HTTP (Port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS (Port 443)
  ingress {
    from_port   = 443
    to_port     = 443
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

# ✅ Output Instance Public IP
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

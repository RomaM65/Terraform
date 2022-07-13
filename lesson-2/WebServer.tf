#-------------------------------------------------
# My terraform
#
#Build WebServer during Bootstrap
#
# Made by Roman Skrylnyk
#-------------------------------------------------


provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "my_web_server" {
  ami                    = "ami-03a71cec707bfc3d7" #Amazon Linux Ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform"  > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My first secur group"


  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

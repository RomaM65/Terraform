provider "aws" {
}


resource "aws_instance" "my_Ubuntu" {
  count         = 1
  ami           = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  tags = {
    Name    = "Ubuntu"
    Owner   = "Roman Skrylnyk"
    Project = "Terraform lessons"
  }
}

variable "region" {
  default = "us-east-1"
}


# Provider
provider "aws" {
  region  = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "aws_ubuntu" {
  instance_type          = "t2.micro"
  ami                    = "ami-0b0ea68c435eb488d"
  key_name               = var.key_name
  user_data              = file("userdata.tpl")
  associate_public_ip_address = true
  subnet_id = "subnet-03f3ba38a09765742"
  security_groups = ["sg-069d146a07125f5ab"]
}
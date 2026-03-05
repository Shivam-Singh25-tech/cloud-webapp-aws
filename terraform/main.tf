provider "aws" {
  region = "ap-south-1"
}

# Existing VPC
data "aws_vpc" "main" {
  id = "vpc-0ab123cd45"
}

# Existing Public Subnet
data "aws_subnet" "public" {
  id = "subnet-0a1234b567"
}

# Existing Private Subnet
data "aws_subnet" "private" {
  id = "subnet-0c1234d890"
}

# Existing Security Group
data "aws_security_group" "web_sg" {
  id = "sg-0a123b456"
}

# EC2 Instance
resource "aws_instance" "backend" {

  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  subnet_id = data.aws_subnet.public.id

  vpc_security_group_ids = [data.aws_security_group.web_sg.id]

  tags = {
    Name = "cloud-backend"
  }

}

# Existing DB Subnet Group
data "aws_db_subnet_group" "db_subnet" {
  name = "project-db-subnet"
}

# RDS Database
resource "aws_db_instance" "mysql" {

  identifier = "project-database-1"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  username = "admin"
  password = "AMJFTLWNPO"

  db_subnet_group_name = data.aws_db_subnet_group.db_subnet.name

  skip_final_snapshot = true

}

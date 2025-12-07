# aws vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "main-vpc"
  }
}

# aws public subnet
resource "aws_subnet" "pub_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_subnet"
  }
}

# aws internet gatway
resource "aws_internet_gateway" "gw_strapi" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IG"
  }
}

# aws route table

resource "aws_route_table" "pub_route1" {
  vpc_id                  = aws_vpc.main.id

  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = aws_internet_gateway.gw_strapi.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# aws subnet association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.pub_route1.id
}

# aws security group
resource "aws_security_group" "public_sg" {
  name                      = "public-sg"
  description               = "Allow web and ssh traffic"
  vpc_id                    = aws_vpc.main.id

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
# user data values

data "template_file" "userdata" {
  template = file("${path.module}/userData.sh")
}


resource "aws_instance" "strapi-production" {
  ami                    = "ami-0ecb62995f68bb549"
  instance_type          = "t3.large"
  subnet_id              = aws_subnet.pub_sub.id
  key_name               = "Connection"
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  root_block_device {
    volume_size = 20 
    volume_type = "gp3"
    delete_on_termination = true
  }

  user_data = data.template_file.userdata.rendered

  tags = {
    Name = "Strapi-Server"
  }
}

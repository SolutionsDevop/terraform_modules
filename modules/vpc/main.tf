# Resource to create a vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Resource to create internet gateway & attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {
  
}

# Resource to create public subnet on availablity zone one (az1)
resource "aws_subnet" "public_subnet_az1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_az1_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet_az1"
    }
}

# Resource to create public subnet on availablity zone two (az2)
resource "aws_subnet" "public_subnet_az2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_az2_cidr
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    map_public_ip_on_launch = true
    tags = {
      Name = "public_subnet_az2"
    }
}

# Resource to create a route table and add public route
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.public_route
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
      Name = "public_route_table"
    }
}

# Resource to associate public subnet az1 to public route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Resource to associate public subnet az2 to public route table
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Resource to create private app subnet in az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_app_subnet_az1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name ="private_app_subnet_az1"
  }
}

# Resource to create private app subnet in az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_app_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_app_subnet_az2"
  }
}

# Resource to create private data subnet on availablity zone one (az1)
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_data_subnet_az1_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "private_data_subnet_az1"
  }
}

# Resource to create private data subnet on availablity zone two (az2)
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_data_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "private_data_subnet_az2"
  }
}
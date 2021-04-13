resource "aws_vpc" "network_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"
}

// Routing

resource "aws_internet_gateway" "network_igw" {
  vpc_id = aws_vpc.network_vpc.id
}

resource "aws_route_table" "network_public_crt" {
  vpc_id = aws_vpc.network_vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.network_igw.id
  }
}

resource "aws_route_table" "network_private_crt" {
  // Empty route table for local access only
  vpc_id = aws_vpc.network_vpc.id
}

// Public Subnet

resource "aws_subnet" "network_public_subnet" {
  vpc_id                  = aws_vpc.network_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "eu-west-2a"
}

resource "aws_route_table_association" "network_crta_public_subnet" {
  subnet_id      = aws_subnet.network_public_subnet.id
  route_table_id = aws_route_table.network_public_crt.id
}

// Private Subnet

resource "aws_subnet" "network_private_subnet" {
  vpc_id            = aws_vpc.network_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = "eu-west-2a"
}

resource "aws_route_table_association" "network_crta_private_subnet" {
  subnet_id      = aws_subnet.network_private_subnet.id
  route_table_id = aws_route_table.network_private_crt.id
}
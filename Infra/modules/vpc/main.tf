resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "mainvpc"
  }
}

resource "aws_subnet" "public" {
    count             = var.subnet_count
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
    availability_zone = data.aws_availability_zone.available.names[count.index]
    tags   = {
      name = "main"
    }

  
}

resource "aws_subnet" "private" {
    count             = var.subnet_count
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 10)
    availability_zone = data.aws_availability_zones.available.names[count.index]
 //aws decides what az to use for both pub and priv

    tags      = {
      name    = "main"
    }

  
}


resource "aws_internet_gateway" "igw" {
  vpc_id      = aws_vpc.main.id

  tags = {
    Name      = "main-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id       = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  
}

resource "aws_route_table_association" "" {
  subnet_id       = aws_subnet.public.id
  route_table_id  = aws_route_table.public.id
  count           = var.subnet_count
}

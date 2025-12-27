resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "mainvpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
// data look up of availabe AZs and reference it in my subnets

resource "aws_subnet" "public" {
    count             = var.subnet_count
    vpc_id            = aws_vpc.main.id
    cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
    availability_zone = data.aws_availability_zone.available.names[count.index]
    tags   = {
      name = "main"
    }
    //created pub sub

  
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
//the door to the internet for the vpc through the igw

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nga" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "pub-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

   route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}
// creates a priv rt routing internet bound traffic to nat



resource "aws_route_table" "public" {
  vpc_id       = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
//Associate the priv route table to all private sub

  


resource "aws_route_table_association" "public" {
  subnet_id       = aws_subnet.public.id
  route_table_id  = aws_route_table.public.id
  count           = var.subnet_count
}
//links the pub route table to the pub sub

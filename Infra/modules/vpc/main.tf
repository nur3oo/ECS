resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
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
  cidr_block        = var.public_subent_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    name = "main"
  }
  //created pub sub


}

resource "aws_subnet" "private" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  //aws decides what az to use for both pub and priv

  tags = {
    name = "main"
  }


}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}
//the door to the internet for the vpc through the igw

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nga" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "pub-nat"
  }


}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nga.id
  }

  tags = {
    Name = "private-rt"
  }
}
// creates a priv rt routing internet bound traffic to nat



resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

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
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
//Associate the priv route table to all private sub




resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
  count          = var.subnet_count
}
//links the pub route table to the pub sub
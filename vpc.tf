resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_classiclink   = "false"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name = "example"
  }
}

resource "aws_subnet" "example-public" {
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = "true"

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-public"
  }
}

resource "aws_subnet" "example-private" {
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1a"

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-private"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example"
  }
}

resource "aws_route_table" "example-public" {
  vpc_id = "${aws_vpc.example.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.example.id}"
  }

  tags {
    Name = "example-public"
  }
}

resource "aws_route_table_association" "example-public" {
  subnet_id      = "${aws_subnet.example-public.id}"
  route_table_id = "${aws_route_table.example-public.id}"
}

resource "aws_eip" "example" {
  vpc = true
}

resource "aws_nat_gateway" "example" {
  allocation_id = "${aws_eip.example.id}"
  subnet_id     = "${aws_subnet.example-public.id}"
  depends_on    = ["aws_internet_gateway.example"]
}

resource "aws_route_table" "example-private" {
  vpc_id = "${aws_vpc.example.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.example.id}"
  }

  tags {
    Name = "example-private"
  }
}

resource "aws_route_table_association" "example-private" {
  subnet_id      = "${aws_subnet.example-private.id}"
  route_table_id = "${aws_route_table.example-private.id}"
}

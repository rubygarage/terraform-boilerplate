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

resource "aws_route_table_association" "example-public-a" {
  subnet_id      = "${aws_subnet.example-public-a.id}"
  route_table_id = "${aws_route_table.example-public.id}"
}

resource "aws_route_table_association" "example-public-b" {
  subnet_id      = "${aws_subnet.example-public-b.id}"
  route_table_id = "${aws_route_table.example-public.id}"
}

resource "aws_route_table_association" "example-public-c" {
  subnet_id      = "${aws_subnet.example-public-c.id}"
  route_table_id = "${aws_route_table.example-public.id}"
}

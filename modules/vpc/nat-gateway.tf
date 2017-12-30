resource "aws_eip" "example" {
  vpc = true
}

resource "aws_nat_gateway" "example" {
  allocation_id = "${aws_eip.example.id}"
  subnet_id     = "${aws_subnet.example-public-a.id}"
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

resource "aws_route_table_association" "example-private-a" {
  subnet_id      = "${aws_subnet.example-private-a.id}"
  route_table_id = "${aws_route_table.example-private.id}"
}

resource "aws_route_table_association" "example-private-b" {
  subnet_id      = "${aws_subnet.example-private-b.id}"
  route_table_id = "${aws_route_table.example-private.id}"
}

resource "aws_route_table_association" "example-private-c" {
  subnet_id      = "${aws_subnet.example-private-c.id}"
  route_table_id = "${aws_route_table.example-private.id}"
}

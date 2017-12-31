resource "aws_eip" "nat" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${element(var.public_subnet_ids, count.index)}"
}

resource "aws_route_table" "route_table" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }

  tags {
    Name = "${var.name}-private"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id = "${element(var.private_subnet_ids, count.index)}"

  route_table_id = "${aws_route_table.route_table.id}"
}

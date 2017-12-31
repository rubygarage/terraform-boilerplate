resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name = "${var.name}-public"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id = "${element(var.public_subnet_ids, count.index)}"

  route_table_id = "${aws_route_table.route_table.id}"
}

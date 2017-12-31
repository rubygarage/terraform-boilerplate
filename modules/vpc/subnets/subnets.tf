resource "aws_subnet" "subnet" {
  vpc_id                  = "${var.vpc_id}"
  count                   = "${length(var.cidr_blocks)}"
  cidr_block              = "${element(var.cidr_blocks, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = "${var.type == "public" ? true : false}"

  tags {
    Name = "${var.name}-${var.type}-${element(var.availability_zones, count.index)}"
  }
}

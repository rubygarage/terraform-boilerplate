resource "aws_subnet" "example-private-a" {
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-central-1a"

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-private-a"
  }
}

resource "aws_subnet" "example-private-b" {
  cidr_block        = "10.0.5.0/24"
  availability_zone = "eu-central-1b"

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-private-b"
  }
}

resource "aws_subnet" "example-private-c" {
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-central-1c"

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-private-c"
  }
}

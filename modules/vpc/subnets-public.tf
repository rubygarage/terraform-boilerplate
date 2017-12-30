resource "aws_subnet" "example-public-a" {
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-public-a"
  }
}

resource "aws_subnet" "example-public-b" {
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-public-b"
  }
}

resource "aws_subnet" "example-public-c" {
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-central-1c"
  map_public_ip_on_launch = true

  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example-public-c"
  }
}

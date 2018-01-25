resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_classiclink   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "example"
  }
}

resource "aws_subnet" "example_public_a" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "example-public-a"
  }
}

resource "aws_subnet" "example_public_b" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags {
    Name = "example-public-b"
  }
}

resource "aws_subnet" "example_public_c" {
  vpc_id                  = "${aws_vpc.example.id}"
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-1c"
  map_public_ip_on_launch = true

  tags {
    Name = "example-public-c"
  }
}

resource "aws_subnet" "example_private_a" {
  vpc_id            = "${aws_vpc.example.id}"
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "example-private-a"
  }
}

resource "aws_subnet" "example_private_b" {
  vpc_id            = "${aws_vpc.example.id}"
  cidr_block        = "10.0.5.0/24"
  availability_zone = "eu-west-1b"

  tags {
    Name = "example-private-b"
  }
}

resource "aws_subnet" "example_private_c" {
  vpc_id            = "${aws_vpc.example.id}"
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-west-1c"

  tags {
    Name = "example-private-c"
  }
}

resource "aws_security_group" "example_rails_staging_elb" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-rails-staging-elb"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-rails-staging-elb"
  }
}

resource "aws_security_group" "example_nodejs_staging_elb" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-nodejs-staging-elb"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-nodejs-staging-elb"
  }
}

resource "aws_security_group" "example_rails_production_elb" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-rails-production-elb"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-rails-production-elb"
  }
}

resource "aws_security_group" "example_nodejs_production_elb" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-nodejs-production-elb"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-nodejs-production-elb"
  }
}

resource "aws_security_group" "example_rails_staging_ecs" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-rails-staging-ecs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = ["${aws_security_group.example_rails_staging_elb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-rails-staging-ecs"
  }
}

resource "aws_security_group" "example_nodejs_staging_ecs" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-nodejs-staging-ecs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = ["${aws_security_group.example_nodejs_staging_elb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-nodejs-staging-ecs"
  }
}

resource "aws_security_group" "example_rails_production_ecs" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-rails-production-ecs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = ["${aws_security_group.example_rails_production_elb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-rails-production-ecs"
  }
}

resource "aws_security_group" "example_nodejs_production_ecs" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-nodejs-production-ecs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = ["${aws_security_group.example_nodejs_production_elb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-nodejs-production-ecs"
  }
}

resource "aws_security_group" "example_staging_rds" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-staging-rds"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.example_rails_staging_ecs.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags {
    Name = "example-staging-rds"
  }
}

resource "aws_security_group" "example_production_rds" {
  vpc_id = "${aws_vpc.example.id}"
  name   = "example-production-rds"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.example_rails_production_ecs.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags {
    Name = "example-production-rds"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = "${aws_vpc.example.id}"

  tags {
    Name = "example"
  }
}

resource "aws_route_table" "example_public" {
  vpc_id = "${aws_vpc.example.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.example.id}"
  }

  tags {
    Name = "example-public"
  }
}

resource "aws_route_table_association" "example_public_a" {
  subnet_id      = "${aws_subnet.example_public_a.id}"
  route_table_id = "${aws_route_table.example_public.id}"
}

resource "aws_route_table_association" "example_public_b" {
  subnet_id      = "${aws_subnet.example_public_b.id}"
  route_table_id = "${aws_route_table.example_public.id}"
}

resource "aws_route_table_association" "example_public_c" {
  subnet_id      = "${aws_subnet.example_public_c.id}"
  route_table_id = "${aws_route_table.example_public.id}"
}

resource "aws_eip" "example" {
  vpc = true
}

resource "aws_nat_gateway" "example" {
  allocation_id = "${aws_eip.example.id}"
  subnet_id     = "${aws_subnet.example_public_a.id}"
  depends_on    = ["aws_internet_gateway.example"]
}

resource "aws_route_table" "example_private" {
  vpc_id = "${aws_vpc.example.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.example.id}"
  }

  tags {
    Name = "example-private"
  }
}

resource "aws_route_table_association" "example_private_a" {
  subnet_id      = "${aws_subnet.example_private_a.id}"
  route_table_id = "${aws_route_table.example_private.id}"
}

resource "aws_route_table_association" "example_private_b" {
  subnet_id      = "${aws_subnet.example_private_b.id}"
  route_table_id = "${aws_route_table.example_private.id}"
}

resource "aws_route_table_association" "example_private_c" {
  subnet_id      = "${aws_subnet.example_private_c.id}"
  route_table_id = "${aws_route_table.example_private.id}"
}

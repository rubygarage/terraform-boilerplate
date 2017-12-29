resource "aws_security_group" "example-ecs" {
  name = "example-ecs"

  vpc_id = "${aws_vpc.example.id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = "8080"
    to_port   = "8080"
    protocol  = "tcp"

    security_groups = ["${aws_security_group.example-elb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "example-ecs"
  }
}

resource "aws_security_group" "example-elb" {
  name = "example-elb"

  vpc_id = "${aws_vpc.example.id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
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
    Name = "example-elb"
  }
}

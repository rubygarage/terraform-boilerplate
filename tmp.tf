resource "aws_instance" "tmp" {
  ami           = "ami-daba31b5"
  instance_type = "t2.nano"

  key_name  = "${aws_key_pair.example.key_name}"
  subnet_id = "${aws_subnet.example-public.id}"

  vpc_security_group_ids = ["${aws_security_group.example-elb.id}"]

  tags {
    Name = "tmp"
  }
}

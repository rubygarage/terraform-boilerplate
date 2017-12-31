resource "aws_instance" "tmp" {
  ami           = "ami-daba31b5"
  instance_type = "t2.nano"

  key_name = "${aws_key_pair.example.key_name}"

  vpc_security_group_ids = ["${var.elb_security_group_id}"]

  subnet_id = "${element(var.public_subnet_ids, count.index % length(var.public_subnet_ids))}"

  tags {
    Name = "tmp"
  }
}

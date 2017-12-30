resource "aws_instance" "tmp" {
  ami           = "ami-daba31b5"
  instance_type = "t2.nano"

  key_name = "${aws_key_pair.example.key_name}"

  vpc_security_group_ids = ["${var.elb-security-group-id}"]

  subnet_id = "${element(var.public-subnet-ids, count.index % length(var.public-subnet-ids))}"

  tags {
    Name = "tmp"
  }
}

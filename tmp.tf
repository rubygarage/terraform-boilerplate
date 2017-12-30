resource "aws_instance" "tmp" {
  ami           = "ami-daba31b5"
  instance_type = "t2.nano"

  key_name = "${aws_key_pair.example.key_name}"

  subnet_id              = "${module.vpc.public-subnet-a-id}"
  vpc_security_group_ids = ["${module.vpc.elb-security-group-id}"]

  tags {
    Name = "tmp"
  }
}

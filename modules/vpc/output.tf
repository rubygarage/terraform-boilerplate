# SECURITY GROUPS:

output "elb-security-group-id" {
  value = "${aws_security_group.example-elb.id}"
}

output "ecs-security-group-id" {
  value = "${aws_security_group.example-ecs.id}"
}

# PUBLIC SUBNETS:

output "public-subnet-a-id" {
  value = "${aws_subnet.example-public-a.id}"
}

output "public-subnet-b-id" {
  value = "${aws_subnet.example-public-b.id}"
}

output "public-subnet-c-id" {
  value = "${aws_subnet.example-public-c.id}"
}

output "public-subnet-ids" {
  value = [
    "${aws_subnet.example-public-a.id}",
    "${aws_subnet.example-public-b.id}",
    "${aws_subnet.example-public-c.id}",
  ]
}

# PRIVATE SUBNETS:

output "private-subnet-a-id" {
  value = "${aws_subnet.example-private-a.id}"
}

output "private-subnet-b-id" {
  value = "${aws_subnet.example-private-b.id}"
}

output "private-subnet-c-id" {
  value = "${aws_subnet.example-private-c.id}"
}

output "private-subnet-ids" {
  value = [
    "${aws_subnet.example-private-a.id}",
    "${aws_subnet.example-private-b.id}",
    "${aws_subnet.example-private-c.id}",
  ]
}

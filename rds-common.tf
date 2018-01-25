resource "aws_db_subnet_group" "example" {
  name = "example"

  subnet_ids = [
    "${aws_subnet.example_private_a.id}",
    "${aws_subnet.example_private_b.id}",
    "${aws_subnet.example_private_c.id}",
  ]
}

resource "aws_db_parameter_group" "example_postgres" {
  name   = "example-postgres"
  family = "postgres9.6"
}

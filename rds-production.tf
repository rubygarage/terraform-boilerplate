resource "aws_db_instance" "example_production" {
  identifier     = "example-production"
  instance_class = "db.t2.micro"

  engine         = "postgres"
  engine_version = "9.6.6"

  allocated_storage = 5
  storage_type      = "gp2"

  name     = "example"
  username = "example"
  password = "${var.rds_example_production_password}"

  db_subnet_group_name   = "${aws_db_subnet_group.example.name}"
  parameter_group_name   = "${aws_db_parameter_group.example_postgres.name}"
  vpc_security_group_ids = ["${aws_security_group.example_production_rds.id}"]

  multi_az = false

  backup_retention_period   = 15
  skip_final_snapshot       = false
  final_snapshot_identifier = "example-production-final-snapshot"

  tags {
    Name = "example-production"
  }
}

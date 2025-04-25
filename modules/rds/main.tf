resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "app_db" {
  identifier             = "app-db"
  engine                 = "postgres"
  engine_version         = "16.4"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "app_db"
  username               = "dbadmin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot    = true
}

output "db_endpoint" {
  value = aws_db_instance.app_db.endpoint
}
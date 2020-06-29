resource "aws_db_subnet_group" "database" {
  name        = "db-sn-group"
  description = "Database subnet group for mysql/backend"
  subnet_ids = aws_subnet.back.*.id

  tags = {
    Name     = "DataBaseSubnetGroup"
  }
}

resource "aws_db_option_group" "memcache-option-group" {
  name                     = "memcache-option-group"
  option_group_description = "Terraform Option Group for MEMCACHED"
  engine_name              = "mysql"
  major_engine_version     = "5.6"

  option {
    option_name = "MEMCACHED"
    port        = 11211
    vpc_security_group_memberships = [ aws_security_group.back_sg.id, ]
    //db_security_group_memberships = 
    // option_settings {
    //   name  = "TIME_ZONE"
    //   value = "UTC"
    // }
  }
}

resource "aws_db_instance" "default" {
  identifier                = "wordpress-db"
  allocated_storage         = 5
  engine                    = "mysql"
  engine_version            = "5.6.35"
  instance_class            = "db.t2.micro"
  name                      = "wpdb"
  username                  = "root"
  password                  = "987654321"
  db_subnet_group_name      = aws_db_subnet_group.database.id
  vpc_security_group_ids    = [ aws_security_group.back_sg.id, ]
  skip_final_snapshot       = true
  final_snapshot_identifier = "Ignore"
  option_group_name         = aws_db_option_group.memcache-option-group.name
}


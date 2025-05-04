module "db" {
  source            = "terraform-aws-modules/rds/aws"
  identifier        = "demodb"
  engine            = "postgres"
  engine_version    = "13.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  username          = "admin"
  password          = "password"
}

output "db_instance_arn" {
  value = module.db.db_instance_arn
}

output "db_instance_address" {
  value = module.db.db_instance_address
}

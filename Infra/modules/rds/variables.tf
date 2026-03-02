variable "ecs_security_group_id" {
  type        = string
  description = "Security group ID attached to ECS tasks that can connect to RDS"
}

variable "name" {
  description = "Project name"
  type        = string
  default = "rds"
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet ids for the DB subnet group"
  type        = list(string)
}

variable "db_name" {
  description = "database name"
  type        = string
  default     = "app"
}

variable "db_username" {
  description = "username for the database"
  type        = string
  default     = "appuser"
}

variable "engine_version" {
  description = "Postgres engine version"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "rds instance class"
  type        = string
  default     = "db.t4g.micro"
}


variable "backup_retention_period" {
  description = "days to retain automated backups"
  type        = number
  default     = 7
}

variable "multi_az" {
  description = "Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Whether the DB has a public endpoint, false becuase it is private"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  default     = true
}

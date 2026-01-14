variable "ecs_security_group_id" {
  type        = string
  description = "Security group ID attached to ECS tasks that can connect to RDS"
}

variable "name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet ids for the DB subnet group"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security Group ID attached to ecs task"
  type        = string
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "app"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "appuser"
}

variable "engine_version" {
  description = "Postgres engine version"
  type        = string
  default     = "16.3"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "storage in GB"
  type        = number
  default     = 20
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

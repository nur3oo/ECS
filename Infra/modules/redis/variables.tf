variable "name" {
  type        = string
  description = "Name prefix for redis resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet Id for redis"
}

variable "ecs_security_group_id" {
  type        = string
  description = "ECS service security group Id allowed to reach redis"
}

variable "node_type" {
  type        = string
  description = "ElastiCache node type (e.g. cache.t4g.micro)"
  default     = "cache.t4g.micro"
}

variable "engine_version" {
  type        = string
  description = "Redis engine "
  default     = "7.0"
}

variable "port" {
  type        = number
  default     = 6379
}

variable "multi_az_enabled" {
  type    = bool
  default = false
}

variable "automatic_failover_enabled" {
  type    = bool
  default = false
}

variable "num_cache_clusters" {
  type        = number
  description = "Number of cache nodes (1 for dev). If you enable failover, set to 2+."
  default     = 1
}
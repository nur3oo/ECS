locals {
  redis_url = "redis://${module.redis.primary_endpoint}:${module.redis.port}"
}
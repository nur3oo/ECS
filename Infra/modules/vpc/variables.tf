variable "private_subnet_cidrs" {
  type = list(any)

}

variable "public_subnet_cidrs" {
  type = list(any)

}

variable "subnet_count" {
  type = number
  default = 2

}


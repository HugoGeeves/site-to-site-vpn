variable "vpc_cidr_block" {
  description = "cidr block for full vpc (consider using /16 mask)"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "cidr block for network public subnet (ensure higher bit mask than vpc_cidr_block)"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "cidr block for network private subnet (ensure higher bit mask than vpc_cidr_block)"
  type        = string
}
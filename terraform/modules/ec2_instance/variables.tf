variable "ami" {
  description = "ami for ec2 instance (default to ubuntu)"
  type        = string
  default     = "ami-096cb92bb3580c759"
}

variable "instance_type" {
  description = "Size of instance to create (defaults to smallest)"
  type        = string
  default     = "t2.micro"
}

variable "vpc" {
  description = "The vpc to associate the instance with"
}

variable "name" {
  description = "The unique name for the instance"
  type        = string
}

variable "source_dest_check" {
  description = "Should the instance act as a NAT router"
  type        = bool
  default     = false
}
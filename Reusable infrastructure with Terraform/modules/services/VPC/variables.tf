variable "cidr_block" {
  type = string
}

variable "public_subnet_count" {
  type    = number
  default = 2
}

variable "public_subnet_cidrs" {
  type = list(string)
}

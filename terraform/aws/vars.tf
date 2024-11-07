# NETWORK VARS CUSTOM VALUES
variable "vpc10_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc20_cidr" {
  type    = string
  default = "20.0.0.0/16"
}

variable "sn_vpc10_pub" {
  type    = string
  default = "us-east-1a"
}

variable "sn_vpc10_pub2" {
  type    = string
  default = "us-east-1a"
}
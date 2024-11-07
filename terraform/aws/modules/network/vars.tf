variable "vpc10_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "vpc20_cidr" {
    type = string
    default = "20.0.0.0/16"
}

variable "sn_vpc10_pub" {
    type = string
    default = "us-east-1a"
}

variable "sn_vpc10_pub2" {
    type = string
    default = "us-east-1a"
}

variable "sn_vpc20_priv" {
    type = string
    default = "us-east-1a"
}

variable "sn_vpc10_pub_cidr" {
    type = string
    default = "10.0.1.0/24"
}

variable "sn_vpc10_pub2_cidr" {
    type = string
    default = "10.1.1.0/24"
}

variable "sn_vpc20_priv_cidr" {
    type = string
    default = "20.0.1.0/24"
}
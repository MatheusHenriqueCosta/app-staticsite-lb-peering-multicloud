variable "vpc10_id" {}
variable "vpc20_id" {}
variable "vpc10_cidr" {}
variable "vpc20_cidr" {}
variable "sn_vpc10_pub" {}
variable "sn_vpc10_pub2" {}
variable "sn_vpc20_priv" {}

variable "ec2_ami" {
    type    = string
    default = "ami-0f409bae3775dc8e5"

    validation {
        condition = (
            length(var.ec2_ami) > 4 &&
            substr(var.ec2_ami, 0, 4) == "ami-"
        )
        error_message = "The valor da variável ec2_ami deve iniciar com \"ami-\"."
    }
}
output "vpc10_id" {
  value = aws_vpc.vpc10.id
}

output "vpc20_id" {
  value = aws_vpc.vpc20.id
}

output "sn_vpc10_pub_id" {
  value = aws_subnet.sn_vpc10_pub.id
}

output "sn_vpc10_pub2" {
  value = aws_subnet.sn_vpc10_pub2.id
}

output "sn_vpc20_priv" {
  value = aws_subnet.sn_vpc20_priv.id
}
output "spoke_vpc_id" {
  value = aws_vpc.spoke-vpc.id
}

output "spoke_vpc_default_route_table_id" {
  value = aws_vpc.spoke-vpc.default_route_table_id
}

output "spoke_igw_id" {
  value = aws_internet_gateway.spoke-igw.id
}

output "spoke-vpc-security-group-id" {
  value = aws_security_group.helloSpokeSecurityGroup.id
}
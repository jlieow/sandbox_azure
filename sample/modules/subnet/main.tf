resource "aws_subnet" "spoke-subnet-a" {
  vpc_id = var.spoke-vpc-id

  cidr_block        = var.spoke_subnet.a.cidr_block
  availability_zone = var.spoke_subnet.a.availability_zone

  tags = {
    Name = "${var.spoke_subnet.a.name}"
  }
}
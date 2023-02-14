provider "aws" {
  region  = "ap-southeast-1"
  profile = var.profile
}

# Get local IP address
data "http" "icanhazip" {
   url = "https://ipv4.icanhazip.com/"
}

# Contains the VPCs, Security Groups, Internet Gateway and Route Tables
module "vpc" {
  source = "./modules/vpc"

  my_ip = data.http.icanhazip.response_body

  spoke_vpc_cidr_block = var.spoke_vpc_cidr_block
}

# Contains the subnets
module "subnet" {
  source = "./modules/subnet"

  spoke-vpc-id = module.vpc.spoke_vpc_id

  spoke_subnet = var.spoke_subnet
}

# Contains EC2s
module "vm-1" {
  source = "./modules/ec2"
  
  spoke-vpc-security-group-id = module.vpc.spoke-vpc-security-group-id
  spoke-subnet-a-id = module.subnet.spoke-subnet-a-id
  vm_name = "vm-1"
}

module "vm-2" {
  source = "./modules/ec2"
  
  spoke-vpc-security-group-id = module.vpc.spoke-vpc-security-group-id
  spoke-subnet-a-id = module.subnet.spoke-subnet-a-id
  vm_name = "vm-2"
}

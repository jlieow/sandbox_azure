## backend.tfvars

variable "profile" {
  description = "AWS CLI profile = sandbox_jerome_1_terraform_admin"
}

variable "region" {
  description = "AWS Region"
}

variable "bucket" {
  description = "S3 bucket to hold the tf state file. ONLY USED IN backend.tf."
}

variable "key" {
  description = "Name of tf state file to be saved in the S3 bucket. ONLY USED IN backend.tf."
}

## config.tfvars

variable "spoke_vpc_cidr_block" {
  description = "Spoke VPC CIDR Block"
}

variable "spoke_subnet" {
    type = map(
        object(
            {
                name                = string
                cidr_block          = string
                availability_zone   = string
            }
        )
    )
}
data "aws_ami" "amzn2-ami-kernel-5" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20221103.3-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_instance" "vm" {
  ami           = data.aws_ami.amzn2-ami-kernel-5.id
  instance_type = "t2.micro"

  tags = {
    Name = var.vm_name
  }

  key_name = "helloKeyPair"

  associate_public_ip_address = true

  vpc_security_group_ids = [ var.spoke-vpc-security-group-id ]
  
  subnet_id = var.spoke-subnet-a-id

  user_data = <<EOF
  #!/bin/bash
  sudo yum install httpd -y
  sudo systemctl enable httpd
  sudo mkdir /var/www/html/orders/
  sudo echo "<h1>This is the Main Spoke App</h1>" > /var/www/html/index.html
  sudo echo "<h1>This is Spoke Orders App</h1>" > /var/www/html/orders/index.html
  sudo systemctl start httpd 
  EOF

}

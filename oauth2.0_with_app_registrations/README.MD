### objective

A sample terraform used to provision 2 VMs, 1 VPC and 1 subnet

### A sample tfvars file is included which should be configured to your needs

backend.tfvars - contains settings used in backend.tf
config.tfvars - contains settings used when applying and destorying configurations

#### init with only the backend.tfvars file

terraform init -backend-config=backend.tfvars

### You can create a server on the VM you want to test TCP connections with using the following:

#### Option 1: Flask Server

1. sudo yum install pip3
2. pip3 install Flask
3. Copy code from hello.py and create hello.py in the VM
4. python3 hello.py

#### Option 2: Apache Server

5. yum install httpd -y
6. systemctl enable httpd
7. mkdir /var/www/html/orders/
8. echo "<h1>This is Orders App</h1>" > /var/www/html/orders/index.html
9. systemctl start httpd

#### Option 3: Apache Server via User Data

Pass this as user data in the ec2_instance block:
user_data = <<EOF
  #!/bin/bash
  sudo yum install httpd -y
  sudo systemctl enable httpd
  sudo mkdir /var/www/html/orders/
  sudo echo "<h1>This is Orders App</h1>" > /var/www/html/orders/index.html
  sudo systemctl start httpd 
  EOF
### Objective


### About

Ubuntu

1. sudo apt update
2. sudo apt install apache2
3. sudo ufw app list
4. sudo ufw allow 'Apache'
5. sudo ufw status
6. sudo systemctl status apache2

RHEL

1. yum install httpd -y
2. systemctl enable httpd
3. systemctl start httpd
4. firewall-cmd --zone=public --permanent --add-service=http
5. firewall-cmd --reload
6. mkdir /var/www/html/orders/
7. echo "<h1>This is Orders App</h1>" > /var/www/html/orders/index.html
8. systemctl start httpd
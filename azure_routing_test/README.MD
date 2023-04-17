### Objective


### About

Ubuntu

```
sudo apt update
sudo apt install apache2
sudo ufw app list
sudo ufw allow 'Apache'
sudo ufw status
sudo systemctl status apache2
```

RHEL

```
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --reload
sudo mkdir /var/www/html/orders/
sudo echo "<h1>This is Orders App</h1>" > /var/www/html/orders/index.html
sudo systemctl start httpd
```
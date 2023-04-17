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
yum install httpd -y
systemctl enable httpd
systemctl start httpd
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --reload
mkdir /var/www/html/orders/
echo "<h1>This is Orders App</h1>" > /var/www/html/orders/index.html
systemctl start httpd
```
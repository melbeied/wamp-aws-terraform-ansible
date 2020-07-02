#! /bin/bash


echo "admin123456789\admin123456789" | sudo adduser admin
sudo usermod -aG sudo admin

sudo apt update
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

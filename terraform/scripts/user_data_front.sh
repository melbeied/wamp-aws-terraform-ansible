#! /bin/bash
sudo apt-get update
sudo apt-get install python-minimal -y
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

echo "admin123456789\admin123456789" | sudo adduser admin
sudo usermod -aG sudo admin

#sudo iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 22 -j ACCEPT
#sudo iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 80 -j ACCEPT
#sudo iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 443 -j ACCEPT
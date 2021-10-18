#!
sudo dnf upgrade -y
hostnamectl set-hostname nisseland.local
useradd pingu
passw pingu password
usermod -aG wheel pingu
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

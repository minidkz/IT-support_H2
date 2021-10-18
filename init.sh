#! /bin/bash
password='password'
allowusers='AllowUsers opc pingu'

dnf upgrade -y
hostnamectl set-hostname jump.nisseland.local
useradd pingu
echo $password | passwd --stdin pingu
usermod -aG wheel pingu
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
sed -i 's/PermitRootLogin=no/g' /etc/ssh/sshd_config
sed -i '$allowusers' /etc/ssh/sshd_config

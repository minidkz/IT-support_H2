#! /bin/bash
password='password'

dnf upgrade -y
hostnamectl set-hostname jump.nisseland.local
useradd pingu
echo $password | passwd --stdin pingu
usermod -aG wheel pingu
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

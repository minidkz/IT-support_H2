#! /bin/bash

dnf upgrade -y
hostnamectl set-hostname jump.nisseland.local
useradd pingu
echo password | passwd --stdin pingu
usermod -aG wheel pingu
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
sed -i 's/PermitRootLogin=no/g' /etc/ssh/sshd_config
echo AllowUsers opc pingu >> /etc/ssh/sshd_config
firewall-cmd --perm --zone=internal --change-interface=enp1s0 
firewall-cmd --perm --zone=internal --remove-service=mdns
firewall-cmd --perm --zone=internal --remove-service=samba-client
firewall-cmd --perm --zone=internal --remove-service=dhcpv6-client
sleep 10s
reboot now

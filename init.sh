#! /bin/bash

#Opdatering
echo "Serveren opdateres!"
dnf upgrade -y -q
echo "==== Serveren er opdateret! ===="

# Ændre hostname
echo Ændre hostname
hostnamectl set-hostname jump.nisseland.local

# Opretter en bruger
echo Opretter brugeren pingu.
useradd pingu
usermod -aG wheel pingu
echo password | passwd pingu --stdin

#Sætter SELinux til Permissive
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

#Fjerner tiladelsen for root til SSH
sed 'N i PermitRootLogin=no' /etc/ssh/sshd_config

#Tillader brugeren pingu til SSH adgang
echo AllowUsers opc pingu >> /etc/ssh/sshd_config

#Netværkport ændres til Internal
firewall-cmd --perm --zone=internal --change-interface=enp1s0 

#Fjerner Services fra Internal
firewall-cmd --perm --zone=internal --remove-service=mdns
firewall-cmd --perm --zone=internal --remove-service=samba-client
firewall-cmd --perm --zone=internal --remove-service=dhcpv6-client

sleep 10s

reboot now

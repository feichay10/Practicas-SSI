#!/bin/bash

# Reset de las reglas
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -Z
iptables -t nat -F
iptables -t nat -X
iptables -t nat -Z

# Acceso ssh al firewall
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i ens3 -p tcp --dport 22 -j ACCEPT

# Acceder desde la red interna (con la ip publica) a los servicios web
iptables -t nat -A PREROUTING -i ens3 -p tcp --match multiport --dports 80,443 -j DNAT --to 192.168.10.100:80 
iptables -t nat -A PREROUTING -i ens4 -d 10.6.129.251 -p tcp --match multiport --dports 80,443 -j DNAT --to-destination 192.168.10.100:80 

# Acceder desde la red interna a servidores Web de Internet
iptables -A FORWARD -i ens4 -p tcp --match multiport --dports 80,443 -j ACCEPT
iptables -A FORWARD -i ens7 -p tcp --match multiport --dports 80,443 -j ACCEPT

# Permite acceder a los servicios web (DMZ) desde internet
iptables -A FORWARD --match state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i ens3 -o ens7 -p tcp --match multiport --dports 80,443 -j ACCEPT

# Permitir tráfico DNS
iptables -A FORWARD -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -p udp --dport 53 -j ACCEPT

iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
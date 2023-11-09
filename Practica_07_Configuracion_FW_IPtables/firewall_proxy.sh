#!/bin/bash

iptables -F
iptables -t nat -F

# Establecer politicas por defecto
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Permitir la conectividad desde la interfaz de loopback
iptables -A INPUT -i lo -j ACCEPT

# Permitir SSH, HTTP, DNS
iptables -A INPUT -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -p tcp --sport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT

# Permitir DNS en el cliente
iptables -A FORWARD -p tcp --sport 53 -j ACCEPT
iptables -A FORWARD -p udp --sport 53 -j ACCEPT
iptables -A FORWARD -p tcp --dport 53 -j ACCEPT
iptables -A FORWARD -p udp --dport 53 -j ACCEPT

# Crear una cadena "SERVICES" y agregar reglas a ella
# Permitir trafico a los puertos 80 y 22
iptables -N SERVICES
iptables -A FORWARD -i ens4 -s 192.168.10.0/24 -j SERVICES
iptables -A SERVICES -p tcp --dport 22 -j ACCEPT
iptables -A SERVICES -p tcp --dport 80 -j ACCEPT
iptables -A SERVICES -p tcp --dport 443 -j ACCEPT

# Para poder hacer ping
iptables -A INPUT -p icmp -j ACCEPT

# Permitir trafico a una impresora desde la red interna
iptables -A FORWARD -i ens4 -o ens4 -s 192.168.10.2 -d 192.168.10.0/24 -j ACCEPT
iptables -A FORWARD -i ens4 -o ens4 -s 192.168.10.0/24 -d 192.168.10.2 -j ACCEPT

# Permitir NAT y redirigir el tráfico del puerto 80 al 8080
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.10.1:8080
iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

# LOGs
iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A LOGGING -j LOG --log-prefix " DROPPED "
iptables -A LOGGING -j DROP
sudo iptables -A INPUT  -j LOG --log-level error --log-prefix "iptablesdropped: "
sudo iptables -A INPUT  -j LOG --log-level error --log-prefix "iptablesdropped: "

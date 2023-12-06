#!/bin/bash

# Políticas por defecto
firewall-cmd --zone=dmz --add-source=192.168.10.0/24
firewall-cmd --zone=internal --add-source=172.16.10.0/24

# ACCEPT para tráfico FW a DMZ y FW a Red Interna
firewall-cmd --permanent --new-policy FWToDMZ
firewall-cmd --permanent --policy FWToDMZ --set-target ACCEPT
firewall-cmd --permanent --policy FWToDMZ --add-ingress-zone HOST
firewall-cmd --permanent --policy FWToDMZ --add-egress-zone dmz
firewall-cmd --permanent --new-policy FWToInt
firewall-cmd --permanent --policy FWToInt --set-target ACCEPT
firewall-cmd --permanent --policy FWToInt --add-ingress-zone HOST
firewall-cmd --permanent --policy FWToInt --add-egress-zone internal

# ACCEPT para tráfico Red Interna a DMZ
firewall-cmd --permanent --new-policy IntToDMZ
firewall-cmd --permanent --policy IntToDMZ --set-target ACCEPT
firewall-cmd --permanent --policy IntToDMZ --add-ingress-zone internal
firewall-cmd --permanent --policy IntToDMZ --add-egress-zone dmz

# ACCEPT para tráfico Red Interna a Internet
firewall-cmd --permanent --new-policy IntToNet
firewall-cmd --permanent --policy IntToNet --set-target ACCEPT
firewall-cmd --permanent --policy IntToNet --add-ingress-zone internal
firewall-cmd --permanent --policy IntToNet --add-egress-zone ANY

# REJECT para tráfico DMZ a Red Interna e Internet a DMZ
firewall-cmd --permanent --new-policy DMZToInt
firewall-cmd --permanent --policy DMZToInt --set-target REJECT
firewall-cmd --permanent --policy DMZToInt --add-ingress-zone dmz
firewall-cmd --permanent --policy DMZToInt --add-egress-zone internal
firewall-cmd --permanent --new-policy DMZToNet
firewall-cmd --permanent --policy DMZToNet --set-target REJECT
firewall-cmd --permanent --policy DMZToNet --add-ingress-zone dmz
firewall-cmd --permanent --policy DMZToNet --add-egress-zone ANY

# DROP para tráfico Internet a FW e Internet a Red Interna
firewall-cmd --permanent --new-policy NetToFW
firewall-cmd --permanent --policy NetToFW --set-target DROP
firewall-cmd --permanent --policy NetToFW --add-ingress-zone external
firewall-cmd --permanent --policy NetToFW --add-egress-zone HOST
firewall-cmd --permanent --new-policy NetToInt
firewall-cmd --permanent --policy NetToInt --set-target DROP
firewall-cmd --permanent --policy NetToInt --add-ingress-zone external
firewall-cmd --permanent --policy NetToInt --add-egress-zone internal

# Trafico DNS para resolucion de nombres al servidor DNS externo
firewall-cmd --permanent --policy NetToInt --add-service=dns
firewall-cmd --permanent --policy NetToFW --add-service=dns

# Tráfico Web desde la red Interna al servidor web de la DMZ
firewall-cmd --permanent --policy IntToDMZ --add-service=http
#!/bin/bash

firewall-cmd --complete-reload
systemctl stop firewalld
systemctl restart firewalld
firewall-cmd --permanent --delete-policy=FWToDMZ
firewall-cmd --permanent --delete-policy=FWToInt
firewall-cmd --permanent --delete-policy=IntToDMZ
firewall-cmd --permanent --delete-policy=IntToNet
firewall-cmd --permanent --delete-policy=DMZToInt
firewall-cmd --permanent --delete-policy=NetToFW
firewall-cmd --permanent --delete-policy=NetToInt
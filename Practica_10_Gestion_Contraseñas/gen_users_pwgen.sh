#!/bin/bash

USERS=("usuario1" "usuario2" "usuario3" "usuario4" "usuario5")

PASSWORDS=()

sudo adduser usuario1
password1=$(pwgen -0 8 -A -1)
echo "usuario1:$password1" | sudo chpasswd
PASSWORDS+=("$password1")

sudo adduser usuario2
password2=$(pwgen -n -1 10)
echo "usuario2:$password2" | sudo chpasswd
PASSWORDS+=("$password2")

sudo adduser usuario3
password3=$(pwgen -y -A 8 -1)
echo "usuario3:$password3" | sudo chpasswd
PASSWORDS+=("$password3")

sudo adduser usuario4
password4=$(pwgen -c -n -y 10 -1)
echo "usuario4:$password4" | sudo chpasswd
PASSWORDS+=("$password4")

sudo adduser usuario5
password5=$(pwgen -c -n -s -B -1 16)
echo "usuario5:$password5" | sudo chpasswd
PASSWORDS+=("$password5")

echo "Usuarios y contrasenias creados:"
echo "--------------------------------"
for ((i=0; i<${#USERS[@]}; i++)); do
  echo "Usuario: ${USERS[i]} | Contrasenia: ${PASSWORDS[i]}"
done
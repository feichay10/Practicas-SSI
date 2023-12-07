#!/bin/bash

USERS=("usuario1" "usuario2" "usuario3" "usuario4" "usuario5")

PASSWORDS=()

# Comprobar si los usuarios ya estan creados
for user in ${USERS[@]}; do
  if id -u $user >/dev/null 2>&1; then
    echo "El usuario $user ya existe"
    continue
  else
    echo "El usuario $user no existe"
    sudo useradd $user
  fi
done

password1=$(pwgen -0 8 -A -1)
password1_md5=$(echo $password1 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
echo "usuario1:$password1_md" | sudo chpasswd
PASSWORDS+=("$password1_md")

password2=$(pwgen -n -1 10)
password2_md5=$(echo $password2 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
echo "usuario2:$password2_md" | sudo chpasswd
PASSWORDS+=("$password2_md")

password3=$(pwgen -y -A 8 -1)
password3_md5=$(echo $password3 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
echo "usuario3:$password3_md5" | sudo chpasswd
PASSWORDS+=("$password3_md5")

password4=$(pwgen -c -n -y 10 -1)
password4_md5=$(echo $password4 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
echo "usuario4:$password4_md5" | sudo chpasswd
PASSWORDS+=("$password4_md5")

password5=$(pwgen -c -n -s -B -1 16)
password5_md5=$(echo $password5 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
echo "usuario5:$password5_md5" | sudo chpasswd
PASSWORDS+=("$password5_md5")

echo "Usuarios y contrasenias creados:"
echo "--------------------------------"
for ((i=0; i<${#USERS[@]}; i++)); do
  echo "Usuario: ${USERS[i]} | Contrasenia: ${PASSWORDS[i]}"
done
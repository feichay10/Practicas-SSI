#!/bin/bash

USERS=("usuario1" "usuario2" "usuario3" "usuario4" "usuario5")

PASSWORDS=()

for user in "${USERS[@]}"; do
  sudo useradd $user
  if [ $user == "usuario1" ]; then
    password1="123456789"
    password1_md5=$(echo $password1 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
    echo "$user:$password1" | sudo chpasswd
    PASSWORDS+=("$password1")
  elif [ $user == "usuario2" ]; then
    password2="usuario1"
    password2_md5=$(echo $password2 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
    echo "$user:$password2" | sudo chpasswd
    PASSWORDS+=("$password2")
  elif [ $user == "usuario3" ]; then
    password3="UsuArio3"
    password3_md5=$(echo $password3 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
    echo "$user:$password3" | sudo chpasswd
    PASSWORDS+=("$password3")
  elif [ $user == "usuario4" ]; then
    password4="_User@4_"
    password4_md5=$(echo $password4 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
    echo "$user:$password4" | sudo chpasswd
    PASSWORDS+=("$password4")
  elif [ $user == "usuario5" ]; then
    password5=$(pwgen  -y -A 8 -1)
    password5_md5=$(echo $password5 | makepasswd --clearfrom=- --crypt-md5 | awk '{ print $2 }')
    echo "$user:$password5" | sudo chpasswd
    PASSWORDS+=("$password5")
  fi
done
#!/bin/bash
lista_alg="-aes-128-cbc -aes-128-ecb -aes-192-cbc -aes-192-ecb -aes-256-cbc -aes-256-ecb -des -des-cbc -des-cfb -des-ecb -des-ede -des-ede-cbc -des-ede-cfb -des-ede-ofb -des-ede3 -des-ede3-cbc -des-ede3-cfb -des-ede3-ofb -des-ofb"
lista_alg_rc="-rc4 -rc4-40"

for alg in $lista_alg_rc; do
  echo $alg
  time openssl enc -e $alg -in DancingMan.txt -out salg.enc -pbkdf2 -salt
  echo -e '\n'
done
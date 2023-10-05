#!/bin/bash
lista_alg="-des-ede3-ecb -des-ede3-cbc -aes-192-cbc -aes-192-ecb"
text_file="text.txt"

# for alg in $lista_alg; do
#   echo $alg
openssl enc -des-ede3-ecb -a -in text.txt -out text_cipher_with_des-ede3-ecb.txt -pbkdf2
openssl enc -des-ede3-ecb -d -a -in text_cipher_with_des-ede3-ecb.txt -out text_decipher_with_des-ede3-ecb.txt -pbkdf2

openssl enc -des-ede3-cbc -a -in text.txt -out text_cipher_with_des-ede3-cbc.txt -pbkdf2
openssl enc -des-ede3-cbc -d -a -in text_cipher_with_des-ede3-cbc.txt -out text_decipher_with_des-ede3-cbc.txt -pbkdf2

openssl enc -aes-192-ecb -a -in text.txt -out text_cipher_with_aes-192-ecb.txt -pbkdf2
openssl enc -aes-192-ecb -d -a -in text_cipher_with_aes-192-ecb.txt -out text_decipher_with_aes-192-ecb.txt -pbkdf2

openssl enc -aes-192-cbc -a -in text.txt -out text_cipher_with_aes-192-cbc.txt -pbkdf2
openssl enc -aes-192-cbc -d -a -in text_cipher_with_aes-192-cbc.txt -out text_decipher_with_aes-192-cbc.txt -pbkdf2

openssl enc -aes-128-cbc -a -in DancingMan.txt -out DancingMan_cipher.txt -pbkdf2
#   echo -e '\n'
# done
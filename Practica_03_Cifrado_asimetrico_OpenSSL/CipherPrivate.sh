#!/bin/bash

# openssl genpkey -algorithm rsa -out clave_privada_rsa_8192.pem -outform PEM -pkeyopt rsa_keygen_bits:8192
# openssl pkey -pubout -in clave_privada_rsa_8192.pem -out pubkey_8192.mem

# openssl pkeyutl -encrypt -in DancingMan_short.txt -out cifrado.txt -inkey pubkey_8192.mem -pubin
# openssl pkeyutl -decrypt -inkey clave_privada_rsa_8192.pem -in cifrado.txt -out descifrado.txt

split -b 1000 DancingMan.txt DancingManEnc.part
openssl pkeyutl -encrypt -in DancingManEnc.partaa -inkey pubkey_8192.mem -pubin  >> cifrado.txt
# openssl pkeyutl -encrypt -in DancingManEnc.partab -inkey pubkey_8192.mem -pubin >> cifrado.txt
openssl pkeyutl -decrypt -inkey clave_privada_rsa_8192.pem -in cifrado.txt -out descifrado.txt
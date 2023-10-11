#!/bin/bash

file="DancingMan.txt"
file_part="DancingMan.part"
file_part_enc="DancingMan.enc"
file_out_enc="DancingMan.enc"
file_out_dec="DancingMan.dec"
pubkey_file="pubkey_8192.mem"
privkey_file="clave_privada_rsa_8192.pem"

# HEXADECIMAL

#encrypt file
split -b 1000 $file $file_part # split the file into 1000 byte parts
for file_part_iterator in $file_part*; do
    openssl pkeyutl -encrypt -in $file_part_iterator -inkey $pubkey_file -pubin >> $file_out_enc # encrypt each part
    # rm $file_part_iterator # remove the unencrypted part
done

#decrypt file
split -b 1000 $file_out_enc $file_part_enc # split the file into 128 byte parts
for file_part_enc_iterator in $file_part_enc*; do
    openssl pkeyutl -decrypt -in $file_part_enc_iterator -inkey $privkey_file -out $file_out_dec # decrypt each part
    # rm $file_part_enc_iterator # remove the encrypted part
done
# openssl pkeyutl -decrypt -in $file_out_enc -inkey $privkey_file -out $file_out_dec
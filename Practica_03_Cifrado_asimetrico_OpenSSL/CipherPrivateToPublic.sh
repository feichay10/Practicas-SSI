#!/bin/bash

file="DancingMan.txt"

# rm DancingMan.dec.part*

# encrypt file
file_part_enc="DancingMan.enc.part"
file_out_enc="DancingMan.enc"
file_out_enc_copy="DancingMan_Copy.enc"
pubkey_file="pubkey_8192.mem"

# decrypt file
file_part_dec="DancingMan.dec.part"
file_out_dec="DancingMan.dec"
file_out_dec_copy="DancingMan_Copy.dec"
privkey_file="clave_privada_rsa_8192.pem"

# HEXADECIMAL

# Comprobar si el archivo existe
if test -f $file_out_enc; then
    echo "El archivo $file_out_enc existe"
    echo "Eliminamos el archivo $file_out_enc..."
    rm $file_out_enc $file_out_enc_copy
    exit 1
else
    echo "El archivo $file_out_enc no existe"
    echo "Creando el archivo $file_out_enc..."
    touch $file_out_enc
    touch $file_out_enc_copy
fi

#encrypt file
split -b 1000 $file $file_part_enc # split the file into 1000 byte parts
for file_part_iterator in $file_part_enc*; do
    openssl pkeyutl -encrypt -in $file_part_iterator -inkey $pubkey_file -pubin >> $file_out_enc_copy # encrypt each part
    cat $file_out_enc_copy | tr '\n' ' ' >> $file_out_enc
    # cat $file_part_iterator | tr '\n' ' ' >> $file_out_enc
    rm $file_part_iterator # remove the unencrypted part
done

#decrypt file
split -b 1000 $file_out_enc $file_part_dec # split the file into 1000 byte parts
for file_part_iterator in $file_part_dec*; do
    openssl pkeyutl -decrypt -padding PKCS1-OAEP -inkey $privkey_file -in $file_part_iterator >> $file_out_dec_copy # decrypt each part
    cat $file_out_dec_copy | tr '\n' ' ' >> $file_out_dec
    # cat $file_part_iterator | tr '\n' ' ' >> $file_out_dec
    # rm $file_part_iterator # remove the unencrypted part
done
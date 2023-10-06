time openssl genpkey -algorithm rsa -out clave_privada.pem -pkeyopt rsa_keygen_bits:2048
echo -e '\n'
time openssl genpkey -algorithm rsa -out clave_privada_2.pem -pkeyopt rsa_keygen_bits:4096 -pkeyopt rsa_keygen_pubexp:65537
echo -e '\n'
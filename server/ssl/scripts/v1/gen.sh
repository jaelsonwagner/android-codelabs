#!/bin/bash

# Create a certificate authority
openssl genrsa -out root-ca.privkey.pem 2048

# Sign the certificate authority
# openssl req -x509 -new -nodes -days 100 -key root-ca.privkey.pem -out root-ca.cert.pem -subj "/C=US/O=Debug certificate/CN=localhost" -extensions v3_ca -config openssl_config.txt
openssl req -x509 -new -nodes -days 100 -key root-ca.privkey.pem -out root-ca.cert.pem -subj="/C=BR/ST=SP/L=Campinas/O=jaws/OU=devs/CN=localhost/"

# create DER format crt for Android
openssl x509 -outform der -in root-ca.cert.pem -out debug_certificate.crt

rm *.pem

# 1. Generate CA's private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=BR/ST=SaoPaulo/L=Campinas/O=JAWS-emitter/OU=Education/CN=CA-emitter/emailAddress=ca.emitter@gmail.com"

echo "> CA's self-signed certificate"
openssl x509 -in ca-cert.pem -noout -text

# 2. Generate web server's private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=BR/ST=SaoPaulo/L=Campinas/O=JAWS-server/OU=Education/CN=MyHttpServer/emailAddress=adm.myhttpserver@gmail.com"

# 3. Use CA's private key to sign web server's CSR and get back the signed certificate
openssl x509 -req -in server-req.pem -days 60 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem

echo "> Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text

echo "> Verify if certificate is valid..."
openssl verify -CAfile ca-cert.pem server-cert.pem

echo "> Server's public key sha256"
openssl x509 -inform pem -pubkey -noout < ca-cert.pem | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | base64
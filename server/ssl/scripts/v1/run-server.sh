#!/bin/bash

./node_modules/http-server/bin/http-server -d -o -c -1 --log-ip true . --ssl --cert root-ca.cert.pem --key root-ca.privkey.pem

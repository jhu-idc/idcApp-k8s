#!/bin/bash

rm -f jwtRS256.key* jwtRS256.key.pub* salt.txt* saml-secrets.yaml

NAMESPACE=linuxdev

echo "Running for namespace: $NAMESPACE"
# generate the jwt
echo -e "\tGenerating jwt private key..."
ssh-keygen -t rsa -b 2048 -m PEM -P "" -f jwtRS256.key > /dev/null 2>&1
echo -e "\tGenerating jwt public key..."
openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub > /dev/null 2>&1

echo -e "\tBase64 encoding jwt bits..."

echo -e "\tGenerating salt..."
# generate random salt and encode it.
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 > salt.txt

echo -e "\tCreating generic secrets.yaml"
# generate the secrets.yaml
kubectl create secret generic -n $NAMESPACE drupal-sealed --dry-run=client -o yaml \
	--from-file=default_salt=./salt.txt \
	--from-file=jwt_private_key=./jwtRS256.key \
	--from-file=jwt_public_key=./jwtRS256.key.pub \
	--from-literal=def_acct_pass=bW9v > secrets.yaml


rm -f jwtRS256.key* jwtRS256.key.pub* salt.txt* 

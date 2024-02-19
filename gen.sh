#!/bin/bash

echo "Enter directory name"
read folder
if [ -d "$folder" ]; then
  echo "Directory exists"
else
  echo -e "mkdir ~/$folder/"
  mkdir ~/$folder
fi

echo "Enter client ID (e.g., client1):"
read client_id

echo "Enter client TLD (e.g., domain.tld):"
read client_tld

echo $folder

echo -e "git clone https://github.com/OpenVPN/easy-rsa.git"
git clone https://github.com/OpenVPN/easy-rsa.git

echo -e "cd easy-rsa/easyrsa3"
cd easy-rsa/easyrsa3

pwd

echo -e "./easyrsa init-pki"
./easyrsa init-pki

echo -e "./easyrsa build-ca nopass"
./easyrsa build-ca nopass

echo -e "./easyrsa build-server-full server nopass"
./easyrsa build-server-full server nopass

echo -e "./easyrsa build-client-full $client_id.$client_tld nopass"
./easyrsa build-client-full $client_id.$client_tld nopass

echo -e "cp pki/ca.crt ~/$folder/"
cp pki/ca.crt ~/$folder/

echo -e "cp pki/issued/server.crt ~/$folder/"
cp pki/issued/server.crt ~/$folder/

echo -e "cp pki/private/server.key ~/$folder/"
cp pki/private/server.key ~/$folder/

echo -e "cp pki/issued/$client_id.$client_tld.crt ~/$folder"
cp pki/issued/$client_id.$client_tld.crt ~/$folder

echo -e "cp pki/private/$client_id.$client_tld.key ~/$folder/"
cp pki/private/$client_id.$client_tld.key ~/$folder/

echo -e "cd ~/$folder/"
cd ~/$folder/
exec bash

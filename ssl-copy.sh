#!/bin/sh

docker-compose exec -it nexus keytool -printcert -sslserver localhost:8443 -rfc | tee nexus.crt
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ./nexus.crt
mkdir -p ~/.docker/certs.d/nexus.wemade.com\:5443/
cp -av ./nexus.crt   ~/.docker/certs.d/nexus.wemade.com\:5443/ca.crt
rm ./nexus.crt
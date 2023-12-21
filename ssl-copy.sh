#!/bin/sh

docker exec pods/`kubectl -n nexus3 get pod -o jsonpath='{.items[0].metadata.name}'` keytool -printcert -sslserver nexus-service:8443 -rfc | tee nexus.crt
security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ./nexus.crt
mkdir -p ~/.docker/certs.d/nexus.wemade.com\:5443/
cp -av ./nexus.crt   ~/.docker/certs.d/nexus.wemade.com\:5443/ca.crt
  rm ./nexus.crt
#!/bin/sh

kubectl exec -n nexus3 pods/`kubectl -n nexus3 get pod -o jsonpath='{.items[0].metadata.name}'` -- keytool -printcert -sslserver nexus-service:8443 -rfc | tee nexus.crt
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ./nexus.crt
mkdir -p ~/.docker/certs.d/nexus-service.nexus3.svc.cluster.local\:5443/
cp -av ./nexus.crt   ~/.docker/certs.d/nexus-service.nexus3.svc.cluster.local\:5443/ca.crt
rm ./nexus.crt

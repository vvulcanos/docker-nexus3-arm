#! /bin/bash

if [ ! -e "$NEXUS_DATA/etc/ssl/keystore.jks" ]; then
mkdir -p "$NEXUS_DATA/etc/ssl"
chmod go-rwx "$NEXUS_DATA/etc/ssl"
keytool -genkeypair -keystore $NEXUS_DATA/etc/ssl/keystore.jks -storepass password -keypass password \
        -alias jetty -keyalg RSA -keysize 2048 -validity 5000 \
        -dname "CN=${CN}, OU=${OU}, O=${ORG}, L=${LOCALITY}, ST=${STATE}, C=${COUNTRY}" \
        -ext "SAN=DNS:${SAN_DNS}" -ext "BC=ca:true"
fi

sh $NEXUS_HOME/bin/nexus run
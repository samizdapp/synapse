#!/bin/bash

export SYNAPSE_SERVER_NAME=synapse
export SYNAPSE_REPORT_STATS=no 

while [ ! -f /yggdrasil/config.conf ]
do
echo "waiting for yggdrasil config"
sleep 5
done

echo "get public key"
PUB=$(jq '.PublicKey' /yggdrasil/config.conf | tr -d '"')
echo $PUB
P1=${PUB:0:63}
P2=${PUB:63:1}
echo $PUB
export SYNAPSE_SERVER_NAME="test.$P1.$P2.yg"
echo $SYNAPSE_SERVER_NAME
# if [ ! -f /data/homeserver.yaml 
# then
    rm /data/homeserver.yaml || true
    rm /data/homeserver.db || true
    /start.py generate
    echo "#" >> /data/homeserver.yaml
    echo "enable_registration: true" >> /data/homeserver.yaml
    # sed '/trusted_key_servers/d' /data/homeserver.yaml > /data/homeserver.yaml
    # sed '/\- server_name/d' /data/homeserver.yaml > /data.homeserver.yaml
    # echo "trusted_key_servers: []" >> /data/homeserver.yaml
    echo "federation_certificate_verification_whitelist:" >> /data/homeserver.yaml
    echo '  - "*.yg"' >> /data/homeserver.yaml
    # echo "federation_verify_certificates: false" >> /data/homeserver.yaml
    # echo "accept_keys_insecurely: true" >> /data/homeserver.yaml
# fi

./watch_hosts.sh & jobs

/start.py


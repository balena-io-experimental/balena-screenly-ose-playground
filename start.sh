#!/usr/bin/env bash

if [ -z ${ALL_INTERFACES+x} ]; then
  echo "Listening on the VPN IP only for Public Device URL"
  # Only expose the server through the VPN / Public Device URL, and not locally
  VPN_IP=$(ip addr show resin-vpn | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
  sed -i 's/\%\%IP\%\%/'"${VPN_IP}"'/g' /root/.screenly/screenly.conf
else
  echo "Listening on all interfaces"
  sed -i 's/\%\%IP\%\%/0.0.0.0/g' /root/.screenly/screenly.conf
fi

python server.py

#!/bin/bash
set -euxo pipefail
cd "$(dirname "$0")"

fly_region="syd"

# Initialise the app config in fly
fly launch --auto-confirm --copy-config --no-deploy --region "$fly_region" --generate-name --dockerignore-from-gitignore
# create a volume so the config is persisted, 1gb way more than we need, but is is the smallest we can create
fly volumes create config --region "$fly_region" --size 1
# Apps using inbound UDP, need an IP address allocated
fly ips allocate-v4
# Deploy the app
fly deploy

# Wait a second for the app to be connectable via ssh
sleep 1

# print the peer credentials
fly ssh console --command "cat /config/peer1/peer1.conf"
# print the peer credentials as a qr code
fly ssh console --command "/app/show-peer 1"
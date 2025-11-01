#!/bin/bash
LIVE_ENV=$1 # blue sau green

PORT=3001
if [ "$LIVE_ENV" == "green" ]; then
  PORT=3002
fi

sudo sed -i "s/proxy_pass http:\/\/localhost:[0-9]*/proxy_pass http:\/\/localhost:$PORT/" /etc/nginx/sites-available/backend.conf
sudo systemctl reload nginx


#!/bin/bash
LIVE_ENV=$1 # blue sau green

PORT=4001
if [ "$LIVE_ENV" == "green" ]; then
  PORT=4002
fi

sudo sed -i "s/proxy_pass http:\/\/localhost:[0-9]*/proxy_pass http:\/\/localhost:$PORT/" /etc/nginx/sites-available/frontend.conf
sudo systemctl reload nginx


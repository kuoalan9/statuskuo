#!/bin/bash

# Start Ghost in the background
node current/index.js &

# Ping every minute and log it
while true; do
    echo "[keepalive] Pinging https://your-ghost-url.com at $(date)"
    curl -s https://your-ghost-url.com > /dev/null
    sleep 60
done
#!/bin/bash

set -e

echo "🔧 Updating package index..."
sudo apt-get update -y

echo "📦 Installing prerequisite packages..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "🔑 Adding Docker’s GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📝 Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating package index (again)..."
sudo apt-get update -y

echo "🐳 Installing Docker Engine..."
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "✅ Docker installed successfully!"

echo "📂 Adding current user to docker group (optional)..."
sudo usermod -aG docker $USER
echo "⚠️ You must log out and log back in (or run 'newgrp docker') for this to take effect."
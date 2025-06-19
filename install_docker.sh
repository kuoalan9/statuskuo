#!/bin/bash

# Docker Installation Script for Containerized Environments
# Compatible with Render.com, Docker containers, and other root environments

set -e  # Exit on any error

echo "🐳 Starting Docker installation..."

# Check if we're in a containerized environment (like Render)
if [[ $EUID -eq 0 ]]; then
   echo "🔧 Running as root (containerized environment detected)"
   USE_SUDO=""
else
   echo "👤 Running as regular user"
   USE_SUDO="sudo"
fi

# Update package list
echo "📦 Updating package list..."
$USE_SUDO apt update

# Install Docker
echo "🔧 Installing Docker..."
$USE_SUDO apt install -y docker.io

# Only manage systemd services if systemctl is available
if command -v systemctl >/dev/null 2>&1; then
    echo "🚀 Starting Docker service..."
    $USE_SUDO systemctl start docker
    $USE_SUDO systemctl enable docker
    SERVICE_STATUS=$($USE_SUDO systemctl is-active docker 2>/dev/null || echo "unknown")
else
    echo "⚠️  systemctl not available - starting Docker daemon manually..."
    # Try to start Docker daemon in background
    if command -v dockerd >/dev/null 2>&1; then
        $USE_SUDO dockerd > /dev/null 2>&1 &
        sleep 5
        SERVICE_STATUS="started-manually"
    else
        echo "⚠️  Docker daemon management not available in this environment"
        SERVICE_STATUS="manual-start-required"
    fi
fi

# Only manage user groups if not root
if [[ $EUID -ne 0 ]]; then
    echo "👤 Adding user $USER to docker group..."
    $USE_SUDO usermod -aG docker $USER
    
    echo "🔄 Applying group membership..."
    newgrp docker <<EOF
    echo "✅ Verifying Docker installation..."
    docker --version
    
    echo "🧪 Testing Docker with hello-world container..."
    docker run --rm hello-world
    
    echo ""
    echo "🎉 Docker installation completed successfully!"
    echo "📝 Docker version: \$(docker --version)"
    echo "🔧 Docker service status: $SERVICE_STATUS"
EOF
else
    echo "✅ Verifying Docker installation..."
    docker --version
    
    # Test if Docker daemon is running
    if docker info >/dev/null 2>&1; then
        echo "🧪 Testing Docker with hello-world container..."
        docker run --rm hello-world
        
        echo ""
        echo "🎉 Docker installation completed successfully!"
        echo "📝 Docker version: $(docker --version)"
        echo "🔧 Docker service status: $SERVICE_STATUS"
        echo "✨ Docker is ready to use!"
    else
        echo ""
        echo "⚠️  Docker installed but daemon not running"
        echo "📝 Docker version: $(docker --version)"
        echo "💡 You may need to start the Docker daemon manually or configure your environment"
    fi
fi
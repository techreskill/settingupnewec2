#!/bin/bash

set -e

echo "🚀 Starting environment setup for Node.js, Docker, and MongoDB..."

# Check for sudo/root
if [ "$EUID" -ne 0 ]; then 
  echo "🔐 Please run this script as root (use sudo)"
  exit 1
fi

# Update system
echo "📦 Updating system packages..."
apt update && apt upgrade -y

# Install essential tools
for pkg in curl git; do
  if ! command -v $pkg &> /dev/null; then
    echo "🔧 Installing $pkg..."
    apt install -y $pkg
  fi
done

# Install Node.js & npm (NodeSource)
if ! command -v node &> /dev/null; then
  echo "🌐 Installing Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  apt install -y nodejs
else
  echo "✅ Node.js already installed: $(node -v)"
fi

# Install Docker
if ! command -v docker &> /dev/null; then
  echo "🐳 Installing Docker..."
  apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt update
  apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
  echo "✅ Docker already installed: $(docker --version)"
fi

# Start and enable Docker
echo "▶️ Starting Docker..."
systemctl enable docker
systemctl start docker

# Add user to docker group
usermod -aG docker ${SUDO_USER:-$USER}

# Run MongoDB in Docker
if ! docker ps | grep -q mongo; then
  echo "📦 Starting MongoDB container..."
  docker run -d --name mongodb \
    -p 27017:27017 \
    -v mongo_data:/data/db \
    mongo
else
  echo "✅ MongoDB container is already running"
fi

echo "✅ Setup complete! 🥳"
echo "👉 Please log out and back in or run: newgrp docker"

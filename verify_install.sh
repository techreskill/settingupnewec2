#!/bin/bash

echo "🧪 Running environment verification..."

# Function to check a command exists
check_command() {
  if ! command -v "$1" &>/dev/null; then
    echo "❌ $1 is not installed or not in PATH"
    exit 1
  else
    echo "✅ $1 is installed: $($1 --version | head -n1)"
  fi
}

# 1. Check node, npm, docker
check_command node
check_command npm
check_command docker

# 2. Check Docker daemon is running
if ! docker info &>/dev/null; then
  echo "❌ Docker is not running"
  exit 1
else
  echo "✅ Docker is running"
fi

# 3. Check MongoDB container is running
if ! docker ps | grep -q "mongo"; then
  echo "❌ MongoDB container is not running"
  exit 1
else
  echo "✅ MongoDB container is running"
fi

# 4. Check MongoDB accepts connections
echo "🔌 Testing MongoDB connectivity..."
if docker exec mongodb mongo --eval "db.stats()" &>/dev/null; then
  echo "✅ MongoDB responded to queries"
else
  echo "❌ MongoDB container is running but not responding"
  exit 1
fi

echo "🎉 All systems go! Environment is correctly set up."

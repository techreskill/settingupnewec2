# 🚀 Smart Environment Setup Script

This repository contains an all-in-one bash script to install:
- Node.js + npm
- Docker
- MongoDB (via Docker)

## ✅ What It Does

- Checks for required tools and installs them if missing
- Uses Docker to launch MongoDB in the background
- Adds your user to the `docker` group
- Fully automated and retry-safe

---

## 🖥️ Requirements

- Ubuntu 20.04 or newer
- `sudo` privileges

---

## ⚡ Quick One-Liner Install

```bash
curl -sSL https://raw.githubusercontent.com/techreskill/settingupnewec2/main/install.sh | sudo bash
```

🛠 What It Does
Updates your system packages

Installs curl, git, and other necessary tools

Installs Node.js v18

Installs Docker CE & Docker Compose plugin

Starts MongoDB in Docker on port 27017

Adds your user to the Docker group

🧹 Cleanup & Logs
MongoDB data is stored in a named Docker volume mongo_data

You can restart MongoDB with:

```bash
docker restart mongodb
```

### To Test

```bash
curl -sSL https://raw.githubusercontent.com/techreskill/settingupnewec2/main/verify_install.sh | sudo bash
```

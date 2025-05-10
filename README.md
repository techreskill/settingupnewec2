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
curl -sSL https://raw.githubusercontent.com/yourusername/yourrepo/main/install.sh | sudo bash

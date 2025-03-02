#!/bin/bash
echo "🚀 Menginstal bot Telegram SHC di VPS..."

# Update & install dependencies
sudo apt update && sudo apt install -y python3 python3-pip shc wget unzip

# Install Python dependencies
pip3 install python-telegram-bot

# Buat direktori untuk bot
sudo mkdir -p /opt/telegram_shc_bot
cd /opt/telegram_shc_bot

# Unduh file dari GitHub (GANTI dengan repo Anda)
GITHUB_REPO="https://raw.githubusercontent.com/svnpro/star7/main"

wget "$GITHUB_REPO/telegram_shc_bot.py" -O telegram_shc_bot.py
wget "$GITHUB_REPO/telegram_shc_bot.service" -O /etc/systemd/system/telegram_shc_bot.service

# Reload systemd dan aktifkan service
sudo systemctl daemon-reload
sudo systemctl enable telegram_shc_bot
sudo systemctl start telegram_shc_bot

echo "✅ Instalasi selesai! Bot sedang berjalan..."

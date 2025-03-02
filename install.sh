#!/bin/bash

echo "🚀 Menginstal bot Telegram SHC di VPS..."

# Update & install dependencies
sudo apt update && sudo apt install -y python3 python3-pip shc wget unzip

# Install Python dependencies
pip3 install python-telegram-bot

# Buat direktori untuk bot
sudo mkdir -p /opt/telegram_shc_bot
cd /opt/telegram_shc_bot

# Unduh dan ekstrak file ZIP dari GitHub
GITHUB_REPO="https://raw.githubusercontent.com/svnpro/star7/main"
wget "$GITHUB_REPO/telegram_shc_bot.zip" -O telegram_shc_bot.zip
unzip -o telegram_shc_bot.zip
rm telegram_shc_bot.zip  # Hapus ZIP setelah ekstraksi

# Set permission agar bot bisa dieksekusi
chmod +x telegram_shc_bot.py

# Konfigurasi service systemd
sudo cp telegram_shc_bot.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable telegram_shc_bot
sudo systemctl start telegram_shc_bot

echo "✅ Instalasi selesai! Bot sedang berjalan..."

# Cek status bot setelah instalasi
sudo systemctl status telegram_shc_bot

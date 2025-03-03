#!/bin/bash
echo "==================="
echo " Menginstal Bot Shc"
echo "==================="
# Update & install dependencies
sudo apt update && sudo apt install -y python3 python3-pip shc wget unzip

# Install Python dependencies
pip3 install python-telegram-bot

# Buat direktori untuk bot
sudo mkdir -p /opt/telegram_shc_bot
cd /opt/telegram_shc_bot

# Unduh file ZIP dari GitHub (GANTI dengan repo Anda)
GITHUB_REPO="https://raw.githubusercontent.com/svnpro/star7/main"
BOT_ZIP="telegram_shc_bot.zip"

wget "$GITHUB_REPO/$BOT_ZIP" -O $BOT_ZIP

# Minta password ZIP dari pengguna
read -s -p "Your License : " ZIP_PASSWORD
echo ""

# Ekstrak file ZIP dengan password
unzip -o -P "$ZIP_PASSWORD" $BOT_ZIP
rm $BOT_ZIP  # Hapus file ZIP setelah diekstrak

# Pindahkan service file ke systemd jika ada
if [ -f "telegram_shc_bot.service" ]; then
    sudo mv telegram_shc_bot.service /etc/systemd/system/
fi

# Reload systemd dan aktifkan service
sudo systemctl daemon-reload
sudo systemctl enable telegram_shc_bot
sudo systemctl start telegram_shc_bot

echo "======================="
echo " Menginstal Bot SHC Done"
echo "======================="
exit 0
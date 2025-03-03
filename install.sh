#!/bin/bash

# Fungsi untuk menampilkan progress bar
progress_bar() {
    local current=$1
    local total=$2
    local progress=$((current * 100 / total))
    local bar=""
    local fill="="
    local empty=" "
    
    for i in $(seq 1 $((progress / 2))); do
        bar="$bar$fill"
    done
    for i in $(seq 1 $((50 - progress / 2))); do
        bar="$bar$empty"
    done

    printf "\r[%-50s] %d%%" "$bar" "$progress"
}

echo "==================="
echo " Menginstal Bot Shc"
echo "==================="

# Update & install dependencies
sudo apt update && sudo apt install -y python3 python3-pip shc wget unzip

# Install Python dependencies
pip3 install python-telegram-bot

# Menampilkan progress bar untuk instalasi dependencies
echo "Installing dependencies, please wait..."
for i in $(seq 1 100); do
    progress_bar $i 100
    sleep 0.05
done
echo -e "\nInstall dependencies done!"

# Buat direktori untuk bot
sudo mkdir -p /opt/telegram_shc_bot
cd /opt/telegram_shc_bot

# Unduh file ZIP dari GitHub (GANTI dengan repo Anda)
GITHUB_REPO="https://raw.githubusercontent.com/svnpro/star7/main"
BOT_ZIP="telegram_shc_bot.zip"

# Menyembunyikan output wget
echo "Mengecek License..."
wget "$GITHUB_REPO/$BOT_ZIP" -O $BOT_ZIP > /dev/null 2>&1

echo -e "\nLicense complete!"

# Minta password ZIP dari pengguna, tampilkan seperti memasukkan lisensi
echo "============================="
echo "📜 Masukkan Lisensi Anda 📜"
echo "============================="
read -s -p "Your License : " ZIP_PASSWORD
echo ""

# Ekstrak file ZIP dengan password
echo "Mengecek License...."
for i in $(seq 1 100); do
    progress_bar $i 100
    sleep 0.02
done
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

# Menampilkan progres bar saat instalasi selesai
echo "======================="
echo " Menginstal Bot SHC Done"
echo "======================="
for i in $(seq 1 100); do
    progress_bar $i 100
    sleep 0.1
done
echo -e "\nInstallation complete!"
exit 0
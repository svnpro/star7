#!/bin/bash

# Fungsi untuk menampilkan progres bar dengan persentase
progress_bar() {
    local current=$1
    local total=$2
    local width=50  # Lebar bar progres
    local filled=$(( (current * width) / total ))  # Menghitung panjang bagian yang terisi
    local empty=$(( width - filled ))  # Menghitung bagian yang kosong

    # Menampilkan progres bar dengan persentase
    printf "\r["
    printf "%0.s#" $(seq 1 $filled)
    printf "%0.s-" $(seq 1 $empty)
    printf "] $(( (current * 100) / total ))%%"
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

# Menampilkan progress bar saat mengunduh file
echo "Downloading bot files, please wait..."
for i in $(seq 1 100); do
    progress_bar $i 100
    sleep 0.05
done
echo -e "\nDownload complete!"

wget "$GITHUB_REPO/$BOT_ZIP" -O $BOT_ZIP

# Minta password ZIP dari pengguna, tampilkan seperti memasukkan lisensi
echo "============================="
echo "📜 Masukkan Lisensi Anda 📜"
echo "============================="
read -s -p "Your License : " ZIP_PASSWORD
echo ""

# Ekstrak file ZIP dengan password
echo "Extracting bot files..."
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
#!/data/data/com.termux/files/usr/bin/bash

clear
echo "================================="
echo "        RAVEN INSTALLER"
echo "   Ultimate Recon Toolkit"
echo "================================="

echo "[+] Updating packages..."
pkg update -y && pkg upgrade -y

echo "[+] Installing dependencies..."
pkg install git curl wget python golang nmap -y

echo "[+] Installing recon tools..."
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/waybackurls@latest

echo "[+] Downloading Raven engine..."
wget -q https://raw.githubusercontent.com/zen-studi/raven/main/raven.sh

chmod +x raven.sh
mv raven.sh $PREFIX/bin/raven

echo ""
echo "[✓] INSTALL SUCCESS!"
echo "Run tool with: raven"

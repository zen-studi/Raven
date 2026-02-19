#!/data/data/com.termux/files/usr/bin/bash

banner(){
clear
echo "================================="
echo "            RAVEN V1"
echo "     Ultimate Recon Toolkit"
echo "================================="
}

recon(){
echo "[+] Target: $target"
mkdir -p raven_$target
cd raven_$target

echo "[+] Finding subdomains..."
subfinder -d $target -silent > subdomains.txt

echo "[+] Checking live hosts..."
cat subdomains.txt | httpx -silent > live.txt

echo "[+] Collecting URLs..."
cat live.txt | gau > urls.txt
cat live.txt | waybackurls >> urls.txt

sort -u urls.txt -o urls.txt
echo "[✓] Recon finished!"
}

jsfinder(){
grep "\.js" urls.txt | sort -u > js.txt
echo "[✓] JS saved!"
}

params(){
grep "=" urls.txt | sort -u > params.txt
echo "[✓] Params saved!"
}

sensitive(){
grep -Ei "admin|login|dashboard|backup|.env|config" urls.txt > sensitive.txt
echo "[✓] Sensitive paths saved!"
}

menu(){
banner
echo "1) Recon Scan"
echo "2) JS Finder"
echo "3) Parameter Finder"
echo "4) Sensitive Finder"
echo "5) Full Auto Recon"
echo "0) Exit"
read -p "Select: " opt

case $opt in
1) read -p "Target: " target; recon ;;
2) jsfinder ;;
3) params ;;
4) sensitive ;;
5)
read -p "Target: " target
recon
jsfinder
params
sensitive
echo "[✓] FULL RECON DONE!"
;;
0) exit ;;
*) echo "Invalid";;
esac
}

menu

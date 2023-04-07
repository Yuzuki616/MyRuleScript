apt update && apt install git -y
git clone https://github.com/Yuzuki616/MyRuleScript.git
cd MyRuleScript/ || exit
mv ./ruler /bin/
mv ./outbound.json /etc/V2bX/custom_outbound.json
mv ./route.json /etc/V2bX/route.json
mkdir /etc/Ruler/
cp ./config.json /etc/Ruler/config.json
chmod +x /bin/ruler
/bin/ruler -conf /etc/Ruler/config.json -region "$1"
crontab -l > /tmp/cron.temp
echo "0 0 * * * /bin/ruler -conf /etc/Ruler/config.json -region $1" >> /tmp/cron.temp
crontab /tmp/cron.temp
rm /tmp/cron.temp
cd ../
rm -rf MyRuleScript/
sed -i 's?#\ /etc/XrayR/route.json?/etc/V2bX/route.json?' /etc/V2bX/config.yml
sed -i 's?#\ /etc/XrayR/custom_outbound.json?/etc/V2bX/custom_outbound.json?' /etc/V2bX/config.yml
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O /etc/V2bX/geoip.dat
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O /etc/V2bX/geosite.dat
V2bX restart
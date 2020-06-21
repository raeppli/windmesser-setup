#!/bin/bash
who=$(whoami)
wd=$(pwd)
if [ "$who $wd" != "root /root" ]; then
	echo "must be root to run this! And the content of the installation folder should be copied to /root "
	exit 1
fi

apt-get update && sudo apt-get upgrade
apt-get install screen mariadb-server php php7.3-mysql php-curl

mysql < create_user_db.sql
mysql -D aeppli_winduster < windmesser_table_structures.sql

#copy missing parts to pi
sudo -u pi cp home/pi/* /home/pi/
chmod ugo+x /home/pi/scripts/*.sh

#add tunnel user
adduser windmesser-tunnel
sudo -u windmesser-tunnel cp home/windmesser-tunnel/* /home/windmesser-tunnel/

#copy init scripts and install them
cp -r etc/* /etc/
pushd /etc/init.d
chmod ugo+x windmesser
chmod ugo+x windmesser-tunnel
update-rc.d windmesser defaults
update-rc.d windmesser-tunnel defaults
popd

#copy crontab for root
cp -r var/* /var/

echo "dtoverlay=w1-gpio,gpiopin=4,extpullup=on" >> /boot/config.txt
echo "Check timezone setting. If wrong do sudo raspi-config, choose internatioalization"

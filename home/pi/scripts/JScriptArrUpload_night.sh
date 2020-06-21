#! /bin/sh
cd /home/pi/Winduster
mv WindData_*_day.js archive
#wget -O timeStamp.js "winduster.aeppli.org/time.php"
#cat timeStamp.js >> WindData_*_night.js
#head -n 5 mobile.html | tail -n 3 | sed "s/ (.*>/;/" | sed "s/:/ =/" > alertValues.js
#cat timeStamp.js >> alertValues.js
#ftp -n ftp.aeppli.org < FTPJScriptUpload_night.ftp_unix &
#ftp -v -n aeppli.cu.cc < FTPJScriptUploadBackup_night.ftp_unix &
rm storeFile.php*
export filename=`ls -t WindData_2*_night.js | head -1 | tr -d '.js'`
script=`php -r '$script = urlencode(file_get_contents(getenv("filename").".js")); echo $script;'`
wget -q --post-data="filename=$filename&script=$script" https://winduster.aeppli.org/storeFile.php &
wget -q --post-data="filename=$filename&script=$script" winduster2.aeppli.org/storeFile.php &
sleep 30
kill %1
kill %2

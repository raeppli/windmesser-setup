#!/bin/bash
cd /home/pi/Winduster
mv Winduster/WindData_*_night.js archive
wget -O timeStamp.js "winduster.aeppli.org/time.php"
rm storeFile.php*
export filename=`ls -t WindData_2*_day.js | head -1 | tr -d '.js'`
script=`php -r '$script = urlencode(file_get_contents(getenv("filename").".js")); echo $script;'`
echo 'wget -q --post-data="filename=$filename&script=$script" https://winduster.aeppli.org/storeFile.php &' > /home/pi/log/upload.log

echo 'wget -q --post-data="filename=$filename&script=$script" winduster2.aeppli.org/storeFile.php &'
#sleep 30
#kill %1
#kill %2
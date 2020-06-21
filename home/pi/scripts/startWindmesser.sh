#!/bin/bash
JAVA_HOME=/usr/bin/java
PATH=${JAVA_HOME}/bin:$PATH
cd /home/pi/Winduster
CLASSPATH="./Windmesser.jar:./mariadb-java-client-2.6.0.jar:./javax.mail.jar:./jakarta.mail-1.6.5.jar"
#echo "maury0510" | sudo -S /etc/init.d/mysql start
java -cp "$CLASSPATH" AlarmSender2 Restart "Windmesser neu gestartet" roger.aeppli@trivadis.com
java -cp "$CLASSPATH" Main jscriptArray dbhost=127.0.0.1


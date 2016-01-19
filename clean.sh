#stop services

/etc/init.d/apache2 stop

stop mysql

service cron stop

#uninstall and reinstall services

apt-get -q -y purge apache2

apt-get -q -y purge mysql-server mysql-client

apt-get install apache2

apt-get install mysql-server mysql-client

rm test2.log

#start services

/etc/init.d/apache2 start

start mysql

service cron start



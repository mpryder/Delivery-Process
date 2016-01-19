#!/bin/bash


cd deploy

tar -zxvf pre_deploy.tgz

rm pre_deploy.tgz

cd NCIRL/Apache

#deploy html files to /var/www  in Apache

cp -R www /var

#deploy scripts to /usr/lib/cgi-bin in Apache

cp -R cgi-bin /usr/lib

#changes permissions on script

chmod +x /usr/lib/cgi-bin/*

cd ..

cd ..

cd ..

cd ..

rm -rf $SANDBOX



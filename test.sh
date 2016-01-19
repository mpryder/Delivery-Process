#!/bin/bash


cd test

tar -zxvf pre_test.tgz

rm pre_test.tgz

cd NCIRL

#opens SQL and shows what was entered in to table in integrtate section

cat<<FINISH | mysql -uroot -ppassword

use dbtest;

select*from custdetails;

FINISH

cd ..

#tar NCIRL and move to deploy folder

tar -czvf pre_deploy.tgz NCIRL

mv pre_deploy.tgz -t /tmp/$SANDBOX/deploy

rm -rf NCIRL

cd ..


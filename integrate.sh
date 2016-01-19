#!/bin/bash


cd integrate

tar -zxvf pre_integrate.tgz

cd NCIRL

#opens SQL and adds in data to custdetails table

cat<<FINISH | mysql -uroot -ppassword

drop database if exists dbtest;

CREATE DATABASE dbtest;

GRANT ALL PRIVILEGES ON dbtest.* TO dbtestuser@localhost IDENTIFIED BY 'dbpassword';

use dbtest;

drop table if exists custdetails;

create table if not exists custdetails (

name         VARCHAR(30)   NOT NULL DEFAULT '',

address         VARCHAR(30)   NOT NULL DEFAULT '');

insert into custdetails (name,address) values ('John Doe','21 Jump Street');

FINISH

cd ..

#tar NCIRL and move to test folder

tar -czvf pre_test.tgz NCIRL

mv pre_test.tgz -t /tmp/$SANDBOX/test

#clean integrate folder

rm -rf NCIRL

cd ..


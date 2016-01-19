#!/bin/bash


cd build

git clone https://github.com/FSlyne/NCIRL.git

#tar NCIRL and move to integrate folder

tar -czvf pre_integrate.tgz NCIRL

mv pre_integrate.tgz -t /tmp/$SANDBOX/integrate

#clean build folder

rm -rf NCIRL

cd ..

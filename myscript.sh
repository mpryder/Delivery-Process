#!/bin/bash


#start clean environment using external script - clean.sh

source /home/testuser/clean.sh


cd /tmp
SANDBOX=sandbox_$RANDOM

mkdir $SANDBOX

cd $SANDBOX

# Make the process directories

mkdir build

mkdir integrate

mkdir test

mkdir deploy


#BUILD

#run Git error script will not build if errorcount greater than 0

source /home/testuser/GitTest.sh

if [ $ERRORCOUNT -eq 0 ]; then

#runs build process from external script - build.sh

source /home/testuser/build.sh

else

echo Cannot continue, Error count is higher than 0 at build process

exit 0

fi

#INTEGRATE

#run mySql error script will not integrate if error count higher than 0

source /home/testuser/mySqlTest.sh

if [ $ERRORCOUNT -eq 0 ]; then

#runs integrate process from external script - integrate.sh

source /home/testuser/integrate.sh

else

echo Cannot continue, Error count is higher than 0 at integrate process

exit 0

fi


#TEST

#run mySql error script will not test if error count higher than 0

source /home/testuser/mySqlTest.sh

if [ $ERRORCOUNT -eq 0 ]; then

#runs test process from external script - test.sh

source /home/testuser/test.sh

else

echo Cannot continue, error count is higher than 0 at test process

exit 0

fi

#DEPLOY

#run Apache  error script will not deploy if error count higher than 0

source /home/testuser/apacheTest.sh

if [ $ERRORCOUNT -eq 0 ]; then

#runs deploy process from external script - deploy.sh

source /home/testuser/deploy.sh

else

echo cannot continue, errorcount is higher than 0 at deploy process

exit 0

fi 

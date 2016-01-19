#!/bin/bash


#level 1 functions

function isApacheRunning {

        isRunning apache2

        return $?

}


function isApacheListening {

        isTCPlisten 80

        return $?

}


function isMysqlListening {

        isTCPlisten 3306

        return $?

}


function isApacheRemoteUp {

        isTCPremoteOpen 127.0.0.1 80

        return $?

}


function isMysqlRemoteUp {

	isTCPremoteOpen 127.0.0.1 3306

	return $?

}


function isMysqlRunning {

        isRunning mysqld

        return $?

}


function isIpGitAlive {

	isIPalive www.github.com

	return $?

}


#level 0 functions

function isRunning {

PROCESS_NUM=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)

if [ $PROCESS_NUM -gt 0 ] ; then

        echo $PROCESS_NUM

        return 1

else

        return 0

fi

}



function isTCPlisten {

TCPCOUNT=$(netstat -tupln | grep tcp | grep "$1" | wc -l)

if [ $TCPCOUNT -gt 0 ] ; then

        return 1

else

        return 0

fi

}


function isUDPlisten {

UDPCOUNT=$(netstat -tupln | grep udp | grep "$1" | wc -l)

if [ $UDPCOUNT -gt 0 ] ; then

        return 1

else

        return 0

fi

}



function isTCPremoteOpen {
timeout 1 bash -c "echo >/dev/tcp/$1/$2" && return 1 ||  return 0
}



function isIPalive {
PINGCOUNT=$(ping -c 5 "$1" | grep "100%" | wc -l)

if [ $PINGCOUNT -ne 1 ] ; then

        return 1

else

        return 0

fi

}


function getCPU {

app_name=$1

cpu_limit="5000"

app_pid=`ps aux | grep $app_name | grep -v grep | awk {'print $2'}`

app_cpu=`ps aux | grep $app_name | grep -v grep | awk {'print $3*100'}`

if [[ $app_cpu -gt $cpu_limit ]]; then

     return 0

else

     return 1

fi

}

#use functions to check for errors

ERRORCOUNT=0


isApacheRunning
if [ "$?" -eq 1 ]; then

        echo 	1. Apache process is Running $(date +"%c")

else

        echo 	1. Apache process is not Running $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi

isApacheListening
if [ "$?" -eq 1 ]; then

        echo 	2. Apache is Listening $(date +"%c")

else

        echo 	2. Apache is not Listening $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi

isApacheRemoteUp
if [ "$?" -eq 1 ]; then

        echo 	3. Remote Apache TCP port is up $(date +"%c")

else

        echo 	3. Remote Apache TCP port is down $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi

isMysqlRunning
if [ "$?" -eq 1 ]; then

        echo 	4. Mysql process is Running $(date +"%c")

else

        echo 	4. Mysql process is not Running $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi

isMysqlListening
if [ "$?" -eq 1 ]; then

        echo 	5. Mysql is Listening $(date +"%c")

else

        echo 	5. Mysql is not Listening $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi

isMysqlRemoteUp
if [ "$?" -eq 1 ]; then

        echo	 6. Remote Mysql TCP port is up $(date +"%c")

else

        echo	 6. Remote Mysql TCP port is down $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi



echo ERROR COUNT is: $ERRORCOUNT


isIpGitAlive
if [ "$?" -eq 1 ]; then

	echo 7. Git.com is pinging, there is a connection to Git $(date +"%c")

else
	echo 7. Git.com is not pinging, there is no connection to Git $(date +"%c")

	ruby sengmail.rb "ryddlemethis@gmail.com" "Connection Problem" "No connection to GitHub for Deployment"

fi


MaxMem=$(top -n 1 -b | grep "Mem" | cut -c 7-14)

UsedMem=$(top -n 1 -b | grep "Mem" | cut -c 25-31)

UsedPer=$(echo "scale=3; $UsedMem/$MaxMem * 100" | bc -l)

echo The total percentage of memory used is: $UsedPer%

if [ $(echo "$UsedPer > 90" | bc) -ne 0 ]; then

        ruby sendgmail.rb "ryddlemethis@gmail.com" "Critical Error" "Too much memory in use"

fi



if [ $ERRORCOUNT -gt 0 ] ; then

ruby sendgmail.rb "ryddlemethis@gmail.com" "Error Notification" "Error in Deployment Project"

fi

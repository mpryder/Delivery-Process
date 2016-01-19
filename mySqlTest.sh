#!/bin/bash


#level 0 function

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

#level 1 function

function isMysqlRunning {

        isRunning mysqld

        return $?

}


function isMysqlListening {

        isTCPlisten 3306

        return $?

}

#checks errors for myscript

ERRORCOUNT=0

isMysqlRunning

 if [ "$?" -eq 1 ]; then

        echo Mysql process is Running $(date +"%c")

else

        echo Mysql process is not Running $(date +"%c")

	ERRORCOUNT=$((ERRORCOUNT+1))

fi


isMysqlListening

if [ "$?" -eq 1 ]; then

        echo Mysql is Listening $(date +"%c")

else

        echo Mysql is not Listening $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi




echo error count is: $ERRORCOUNT


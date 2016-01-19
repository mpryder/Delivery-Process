#!/bin/bash

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

#level 1 functions

function isApacheRunning {

        isRunning apache2

        return $?

}

function isApacheListening {

        isTCPlisten 80

        return $?

}


#error check myscript

ERRORCOUNT=0

isApacheRunning
 
if [ "$?" -eq 1 ]; then

        echo Apache process is Running $(date +"%c")

else

        echo Apache process is not Running $(date +"%c")

	ERRORCOUNT=$((ERRORCOUNT+1))

fi


isApacheListening

if [ "$?" -eq 1 ]; then

        echo Apache is Listening $(date +"%c")

else

        echo Apache is not Listening $(date +"%c")

        ERRORCOUNT=$((ERRORCOUNT+1))

fi



echo error count is: $ERRORCOUNT

#!/bin/bash


#level 0 function

function isIPalive {

PINGCOUNT=$(ping -c 9 "$1" | grep "100%" | wc -l)

if [ $PINGCOUNT -ne 1 ] ; then

        return 1

else

        return 0

fi

}

#level 1 function

function isIpGitAlive {

	isIPalive www.github.com

	return $?

}

ERRORCOUNT=0

isIpGitAlive

if [ "$?" -eq 1 ]; then

	echo  Git.com is pinging, there is a connection to Git $(date +"%c")

else

	echo  Git.com is not pinging, there is no connection to Git $(date +"%c")

	ERRORCOUNT=$((ERRORCOUNT+1))

fi




echo ERROR COUNT is: $ERRORCOUNT
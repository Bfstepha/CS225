#!/bin/bash

trap "NoSorting" SIGINT

. ~/Projects/CS225/library.sh

DIRECTORY=~/Projects/CS225/finalfiles/

LSDIR=$( find $DIRECTORY )

#FILELINE=$(stat --format '%y')

TMP=$(mktemp)


while getopts :fdth opt ;do

   case $opt in
        f)FORCE="true" ;;
	d)set -x ;;
	t)TARUNZIP ;;
        h) echo "Your options in $0 are:
         -f Force is enable/true
	 -d Turns on debugging
	 -t Unzips finalfiles.tar.gz for txt files
         -h Help " ;;
         \?) echo "Unknown option" ;;
   esac
done
shift $(($OPTIND-1))

for LINE in $LSDIR ;do

	if [ ! -d $LINE ] ;then

		GetTimeStamp
		CheckDirectory

		if [ -z $FORCE ] ;then

			copyfiles
		else

			movefiles

		fi
	fi
done

cleanup

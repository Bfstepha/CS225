#!/bin/bash

trap "NoSorting" SIGINT

. ~/Projects/CS225/library.sh

if_Exif

if_Exiftool

rm -Rf ~/Projects/CS225/finalfiles/2016

DIRECTORY=~/Projects/CS225/finalfiles

LSDIR=$( find $DIRECTORY )

#FILELINE=$(stat --format '%y')

TMP=$(mktemp)
#TMP1=$(mktemp)
#TMP2=$(mktemp)
#TMP3=$(mktemp -d)

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
		#	CheckCameraMakeModelDT
		else

			movefiles
		#	CheckCameraMakeModelDT
		fi
	fi
CheckCameraMakeModelDT
done

cleanup

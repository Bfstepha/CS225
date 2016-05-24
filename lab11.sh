#!/bin/bash

trap "NoSorting" SIGINT

. ~/Projects/CS225/functionLibrary.sh


#rm -Rf ~/Projects/CS225/timefiles/2005
rm -Rf ~/Projects/CS225/timefiles/2016


DIRECTORY=~/Projects/CS225/timefiles/

LSDIR=$( find $DIRECTORY )

TARUNZIP()
{  
	cd /root/Projects/CS225
	tar -xzf /root/Projects/CS225/timefiles.tar.gz 
}
#FILELINE=$(stat --format '%y')

while getopts :fth opt ;do

   case $opt in
        f)FORCE="true" ;;
	t)TARUNZIP ;;
        h) echo "Your options in $0 are:
         -f Force is enable/true
	 -t Unzips timefiles.tar.gz for txt files
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


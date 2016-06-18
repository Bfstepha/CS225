#!/bin/bash
# Brian Stephan
# 6/17/2016
# final.sh


#trap "TRAP_C" SIGINT

trap "TRAP_T" SIGTERM

trap "trapCleanup" SIGINT SIGTERM

#trap "Error" INT TERM

. ~/Projects/CS225/library.sh

# Checking if packages are installed:
echo -e "Checking if all necessary packages are installed. Please wait as this may take up to a minute."

if_exiv2 INSTALL

echo "Exiv2 is installed!"

if_exiftool INSTALL

echo "Exiftool is installed!"


#rm -Rf ~/Projects/CS225/finalfiles/2016

#declare -a YEAR MONTH DAY

DIRECTORY=~/Projects/CS225/finalfiles

LSDIR=$( find $DIRECTORY )

#FILELINE=$(stat --format '%y')

while getopts :fdth opt ;do

   case $opt in
        f)FORCE="true" ;;
	d)set -x ;;
	t)TARUNZIP ;;
        h) echo "Your options in $0 are:
         -f Force is enable/true
	 -d Turns on debugging
	 -t Unzips finalfiles.tar.gz for image and video files
         -h Help " ;;
         \?) echo "Unknown option" ;;
   esac
done
shift $(($OPTIND-1))

PictureCounter=0
VideoCounter=0
PictureDuplicate=0
VideoDuplicate=0
Sort=0
FileCount=0

TMPS=$(mktemp /root/Projects/CS225/tmps.XXXXXX)

#TMP=$(mktemp)
#TMP1=$(mktemp)
#TMP2=$(mktemp)
#TMP3=$(mktemp)
#TMP4=$(mktemp)
#TMP5=$(mktemp -d)
#TMP6=$(mktemp)
#TMP7=$(mktemp)

for FILE in $LSDIR ;do
  
	(( FileCount ++ ))

done


for FILE in $LSDIR ;do
  
if [[ "$FILE" == *.JPG ]] ;then

	EXIV2 ${FILE}
else

	TIME ${FILE}
fi

	CreateDirectory ${FILE}
  	
	(( Sort++ ))

if [[ ! -e $DEST ]] ;then
   
	FilesCopyingMoving
else
	TMP_MD5SUM
    
if [[ "$Duplicate" -ne 1 ]] ;then
     
	FilesCopyingMoving
	
	fi
fi
	Duplicate=""

done

Summary

cleanup





#for LINE in $LSDIR ;do

#	if [ ! -d $LINE ] ;then

#		GetTimeStamp
#		CheckDirectory

#		if [ -z $FORCE ] ;then

#			copyfiles 
		#	CheckCameraMakeModelDT
#		else

#			movefiles
		#	CheckCameraMakeModelDT
#		fi
#	fi
#CheckCameraMakeModelDT
#done

#cleanup

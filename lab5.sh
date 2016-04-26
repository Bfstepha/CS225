#!/bin/bash

MEDIA="/root/Projects/CS225/medialab/"

TEXTMEDIA=$( cat /root/Projects/CS225/medialab/medialist.txt )

IFS=$'\n'

for item in $TEXTMEDIA ;do

	if [ -e "${MEDIA}/${item}" ] ;then
	
	echo "$item is in the medialab folder" >> /root/Projects/CS225/foundfiles.txt
	
	else
	
	echo "$item is not in the medialab folder" >> /root/Projects/CS225/lostfiles.txt

	fi

done

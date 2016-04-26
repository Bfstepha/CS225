#!/bin/bash

rm -f ~/Projects/CS225/textmedialost.txt
rm -f ~/Projects/CS225/medialost.txt 

DIR="/root/Projects/CS225/medialab/"
MEDIA=$(ls /root/Projects/CS225/medialab/ )

TEXTMEDIA=$( cat /root/Projects/CS225/medialab/media.xml | grep  "\.mp" | awk -F '>' '{ print $2 }' | awk -F '<' '{ print $1 }'  )

xmlLost=0
xmlFileLost=0

for item in $TEXTMEDIA ;do
	if [ ! -f "${DIR}/${item}" ] ;then 	
		echo $item >> ~/Projects/CS225/textmedialost.txt
		((xmlFileLost++))
	fi

done
#loop thru files and not found in media.xml
for line in $MEDIA ;do
	if ! grep -q $line /root/Projects/CS225/medialab/media.xml  ;then
		echo $line >> ~/Projects/CS225/medialost.txt
		(( xmlLost++))
	fi
done

echo "Files not in media.xml: "
cat ~/Projects/CS225/medialost.txt
echo "Files not in medialab directory: "
cat ~/Projects/CS225/textmedialost.txt

echo " $xmlLost media files in medialab directory that are NOT listed in media.xml"
echo " $xmlFileLost media files in media.xml that are NOT in medialab directory"



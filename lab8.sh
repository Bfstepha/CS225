#!/bin/bash

textfile=$( tail -n 1 /root/Projects/CS225/addresses.csv )

#echo " ${textfile} "

#echo " ${textfile##*,} "

FNAME=${textfile%%,*}
textfile=${textfile#*,}
LNAME=${textfile%%,*}
textfile=${textfile#*,}
COMPANY=${textfile%%,*}
textfile=${textfile#*,}
STREET=${textfile%%,*}
textfile=${textfile#*,}
CITY=${textfile%%,*}
textfile=${textfile#*,}
COUNTY=${textfile%%,*}
textfile=${textfile#*,}
STATE=${textfile%%,*}
textfile=${textfile#*,}
ZIP=${textfile%%,*}
textfile=${textfile#*,}
HPHONE=${textfile%%,*}
textfile=${textfile#*,}
WPHONE=${textfile%%,*}
textfile=${textfile#*,}
EMAIL=${textfile%%,*}
textfile=${textfile#*,}
WEBURL=${textfile%%,*}
textfile=${textfile#*,}


echo $FNAME
echo $LNAME
echo $COMPANY
echo $STREET
echo $CITY
echo $STATE
echo $ZIP
echo $HPHONE
echo $WPHONE
echo $EMAIL
echo $WEBURL

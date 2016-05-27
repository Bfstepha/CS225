#!/bin/bash

Source=$( cat /var/share/CS225/addresses.csv )

trap "addresstrap" SIGINT

addresstrap()
{
echo "   Information being displayed stopped!!!! "
echo "   Exiting.... "
exit

}

declare -a FNAME LNAME COMPANY STREET CITY COUNTY STATE ZIP HPHONE WPHONE EMAIL WEBURL

COUNTER=0

OLDIFS="$IFS"
#IFS=$','

IFS=$'\n'

#echo " ${textfile} "

#echo " ${textfile##*,} "

for textfile in $Source ;do

textfile=${textfile#\"}
FNAME[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
LNAME[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
COMPANY[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
STREET[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
CITY[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
COUNTY[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
STATE[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
ZIP[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
HPHONE[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
WPHONE[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
EMAIL[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}
WEBURL[$COUNTER]=${textfile%%\"*}
textfile=${textfile#*,\"}


#echo "counter is $COUNTER"

echo \""${FNAME[$COUNTER]}"\",\""${LNAME[$COUNTER]}"\",\""${COMPANY[$COUNTER]}"\",\""${STREET[$COUNTER]}"\",\""${CITY[$COUNTER]}"\",\""${COUNTY[$COUNTER]}"\",\""${STATE[$COUNTER]}"\",\""${ZIP[$COUNTER]}"\",\""${HPHONE[$COUNTER]}"\",\""${WPHONE[$COUNTER]}"\",\""${EMAIL[$COUNTER]}"\",\""${WEBURL[$COUNTER]}"\"


((COUNTER++))

done



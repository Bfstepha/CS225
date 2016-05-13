#!/bin/bash

cleanup()
{
        # removes tmp

        rm -Rf $TMP
	echo "Cleaned up tmp file"

        exit
}

trap "cleanup" SIGINT

# set vars

TMP=$(mktemp)
VAR=$(find /)



xmlFile=0

for FILE in $VAR ;do
   line=${FILE##*/}
   ((xmlFile++))
echo "File $xmlFile : $line" >> $TMP

done

cat $TMP 



#!/bin/bash

CheckDirectory()
{

	if [ ! -d "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}" ] ;then
        	mkdir -p "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}"
	fi

}

copyfiles()
{

        cp $LINE "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}"

}

movefiles()
{

	 mv $LINE "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}"

}

GetTimeStamp()
{

		TMP=$(stat --format '%y' "$LINE")
                TMP=${TMP%%' '*}
                YEAR=${TMP%%-*}
                TMP=${TMP#*-}
                MONTH=${TMP%%-*}
                TMP=${TMP#*-}
                DAY=${TMP%%-*}

}

NoSorting()
{
	echo "Text files sorting stopped"
}

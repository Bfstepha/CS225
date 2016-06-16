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

CheckCameraMakeModelDT()
{

		

}

NoSorting()
{
	echo "Media files sorting stopped"
}

cleanup()
{
        # removes tmp

        rm -Rf $TMP
        echo "Cleaned up tmp file"

        exit
}


TARUNZIP()
{
        cd /root/Projects/CS225
        tar -xzf /root/Projects/CS225/finalfiles.tar.gz
}


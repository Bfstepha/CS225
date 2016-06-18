#!/bin/bash

# Checking if exiv2 is installed or needs to be installed
if_Exif()
{

exiv2 &>/dev/null
if [[ ${?} = 127 ]] ;then

	logger "Installing Exif (exiv2) from ${0} script."
	yum -y install exiv2 &>~/Projects/CS225/installexiv2.log
	echo "Exif (exiv2) is installed!"
	
else 
	logger "Exif (exiv2) is already installed"
	echo "Exif (exiv2) is already installed"
fi

} &>~/Projects/CS225/exiv2.log


# Checking if exiftool is installed or needs to be installed
if_Exiftool()
{

exiftool &>/dev/null
if [[ ${?} = 127 ]] ;then

	logger "Installing Exiftool from ${0} script."
	yum -y install perl-ExtUtils-MakeMaker &>~/Projects/CS225/perl-ExtUtils.log
	# Using temp dir to download and unzip program files
	# Got this idea from http://www.sno.phy.queensu.ca/~phil/exiftool/install.html
	TMP4=$(mktemp -d)
	cd ${TMP5}
	wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.20.tar.gz
	gzip -dc Image-ExifTool-10.20.tar.gz | tar -xf -
	cd Image-ExifTool-10.20/
	perl Makefile.PL
    	make test
    	make install
	cd
	rm -Rf ${TMP5}
else
	
	logger "Exiftool is already installed."
	echo "Exiftool is already installed."

fi	
} &>~/Projects/CS225/exiftool.log 


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

#2014-8-24_8-30-16_Canon-S80_2.jpg
CheckCameraMakeModelDT()
{
TMP1=${File_Name}
TMP2=${Create_Date}
TMP3=${Camera_Model}
TMP4=${Camera_Make}

exiftool -t | grep File | awk '{ print $3 }' | grep .jpg =$File_Name
exiftool -t | grep "Create\|^Modification Date$" | awk '{ print $3,$4 }' =$Create_Date
exiftool -t | grep Camera | awk '/Name/{ print $4 }' =$Camera_Model
exiftool -t | grep Make | awk '{ print $2 }' =$Camera_Make

if [ ! ${model} ] ;then 
	exiftool '-FileName<${model;} ${CreateDate}' -d %Y-%m-%d_%I-%M-%S%%-c.%%e $DIRECTORY/$YEAR/$MONTH/$DAY

else

	 exiftool '-FileName<${CreateDate}' -d %Y-%m-%d_%I-%M-%S_UNKNOWN%%-c.%%e $DIRECTORY/$YEAR/$MONTH/$DAY

fi
}

CheckVideoNameDT()
{

 TMP6=${Video_File_Name}
 TMP7=${Video_Date_Time}

 exiftool -t | grep File | awk '{ print $3 }' | grep '.AVI\|.mts' =$Video_File_Name
 exiftool -t | grep Date/Time | awk '/Original/{ print $3,$4 }' | sed 's/......$//' =$Video_Date_Time

 if [ ! ${model} ] ;then
         exiftool '-FileName<${model;} ${CreateDate}' -d %Y-%m-%d_%I-%M-%S%%-c.%%e $DIRECTORY/$YEAR/$MONTH/$DAY

else

	 exiftool '-FileName<${CreateDate}' -d %Y-%m-%d_%I-%M-%S_UNKNOWN%%-c.%%e $DIRECTORY/$YEAR/$MONTH/$DAY

 fi

}

NoSorting()
{
	echo "Media files sorting stopped"
	cleanup
}

cleanup()
{
        # removes TMP files

        rm -Rf $TMP
	rm -Rf $TMP1
	rm -Rf $TMP2
	rm -Rf $TMP3
        echo "Cleaned up TMP files"

        exit
}


TARUNZIP()
{
        cd /root/Projects/CS225
        tar -xzf /root/Projects/CS225/finalfiles.tar.gz
}


#!/bin/bash

# Checking if exiv2 is installed or needs to be installed
ifExif()
{

exiv2 &>/dev/null
if [[ ${?} = 127 ]] then

	logger "Installing Exif (exiv2) from ${0} script."
	yum -y install exiv2 &>~/Projects/CS225/installexiv2.log
	echo "Exif (exiv2)is installed!"
	
else 
	logger "Exif (exiv2) is already installed"
	echo "Exif (exiv2) is already installed"
fi

} &>~/Projects/CS225/exiv2.log


# Checking if exiftool is installed or needs to be installed
ifExiftool()
{

exiftool &>/dev/null
if [[ ${?} = 127 ]] then

	logger "Installing Exiftool from ${0} script."
	yum -y install perl-ExtUtils-MakeMaker &>~/Projects/CS225/perl-ExtUtils.log
	# Using temp dir to download and unzip program files
	# Got this idea from http://www.sno.phy.queensu.ca/~phil/exiftool/install.html
	cd ${TMP3}
	wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.20.tar.gz
	gzip -dc Image-ExifTool-10.20.tar.gz | tar -xf -
	cd Image-ExifTool-10.20/
	perl Makefile.PL
    	make test
    	make install
	cd
	rm -Rf ${TMP3}
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

CheckCameraMakeModelDT()
{

		exiftool 		

}

NoSorting()
{
	echo "Media files sorting stopped"
}

cleanup()
{
        # removes TMP files

        rm -Rf $TMP
	rm -Rf $TMP1
	rm -Rf $TMP2
        echo "Cleaned up TMP files"

        exit
}


TARUNZIP()
{
        cd /root/Projects/CS225
        tar -xzf /root/Projects/CS225/finalfiles.tar.gz
}


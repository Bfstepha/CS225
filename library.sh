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
	TMP3=$(mktemp -d)
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

#Setup Function
Start_Setup()
{
	#used with the -f option
	MOVE="FALSE"
	
	#Arrays and Counters
	declare -a YEAR; counterY=0; iY=0; 
	declare -a MONTH; counterM=0; iM=0;
	declare -a DAY; counterD=0; iD=0;

	="$OPTARG"


}

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
if [ ! ${model} ] ;then 
	exiftool '-FileName<CreateDate' -d %Y-%m-%d_%H-%M-%S_${model;}%%_c.%%e 

else

	 exiftool '-FileName<CreateDate' -d %Y-%m-%d_%H-%M-%S_UNKNOWN%%_c.%%e 

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
        echo "Cleaned up TMP files"

        exit
}


TARUNZIP()
{
        cd /root/Projects/CS225
        tar -xzf /root/Projects/CS225/finalfiles.tar.gz
}


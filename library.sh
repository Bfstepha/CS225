#!/bin/bash
# Brian Stephan
# library.sh

# Checking if exiv2 is installed or needs to be installed

# Function to install/remove exiv2:

if_exiv2()
{

# Installing the exiv2

if [ ${1} == INSTALL ] ;then

	exiv2 &>/dev/null
	
	if [[ ${?} = 127 ]] ;then

        logger "Installing exiv2 in preparation for running ${0} script."
       
	echo "Exiv2 was not found on your system; installing..." | tee ~/Projects/CS225/exiv2.log
	yum -y install exiv2 &>>~/Projects/CS225/exiv2.log
        
	if [[ ${?} = 0 ]] ;then

	echo "The package exiv2 was installed successfully!" | tee -a ~/Projects/CS225/exiv2.log
        
	fi

else

	echo "Exiv2 appears to be installed and is working properly, continuing..." | tee -a ~/Projects/CS225/exiv2.log
    
	fi

fi

# Removing the exiv2:

if [ ${1} == REMOVE ] ;then
    
	logger "Removing the exiv2 using the ${0} script."
	
	echo "Removing the exiv2 package..." | tee -a ~/Projects/CS225/exiv2.log
	
	yum -y remove exiv2 &>>~/Projects/CS225/exiv2.log

	if [[ ${?} = 0 ]] ;then
        
	echo "The package exiv2 was removed successfully!" | tee -a ~/Projects/CS225/exiv2.log

	
	fi
fi

} 2>>~/Projects/CS225/exiv2.log



# Checking if exiftool is installed or needs to be installed
# Function to install/remove exiftool:

if_exiftool()
{

# Installing the exiftool

if [ ${1} == INSTALL ] ;then

exiftool ${0} &>/dev/null

if [[ ${?} = 127 ]] ;then

	logger "Installing exiftool in preparation for running ${0} script."
	echo "ExifTool was not found on your system; installing..." | tee ~/Projects/CS225/exiftool.log
        
	# Installing required package perl-ExtUtils-MakeMaker:
	if [[ ! $(rpm -q perl-ExtUtils-MakeMaker) = 0 ]] ;then

	echo "Installing required package perl-ExtUtils-MakeMaker..." | tee ~/Projects/CS225/perl-ExtUtils.log
	yum -y install perl-ExtUtils-MakeMaker &>>~/Projects/CS225/perl-ExtUtils.log

	fi

	# Using temp dir to download and unzip the program files
	# Got this idea from http://www.sno.phy.queensu.ca/~phil/exiftool/install.html
	# Installing exiftool from source: http://www.sno.phy.queensu.ca/~phil/exiftool/
	# The following installs a specific version of Image-ExifTool.
	# If the command fails then it will verify if the program version haven't changed.
	
	ExifVer=Image-ExifTool-10.20
	TMP1=$(mktemp -d)
	cd ${TMP1}

	echo "Downloading ExivTool installation files..." | tee -a ~/Projects/CS225/exiftool.log
	wget http://www.sno.phy.queensu.ca/~phil/exiftool/${ExifVer}.tar.gz &>>~/Projects/CS225/exiftool.log
	
	echo "Extracting ExivTool installation files..." | tee -a ~/Projects/CS225/exiftool.log
        gzip -dc ${ExifVer}.tar.gz | tar -xf - &>>~/Projects/CS225/exiftool.log
        cd ${ExifVer}

	perl Makefile.PL &>>~/Projects/CS225/exiftool.log
	
	echo "Performing internal tests before installation (It shouldn't take long)..." | tee -a ~/Projects/CS225/exiftool.log
        
	make test &>>~/Projects/CS225/exiftool.log
        
	if [ ! $? == 0 ] ;then
	
		echo "The tests were not successful. Please review exiftool.log for errors."

		else

		echo "The tests comleted successfully!"
        
	fi

	echo "Continuing with ExifTool installation..."
        
	make install &>>~/Projects/CS225/exiftool.log

	if [[ ${?} = 0 ]] ;then

		echo "ExifTool was installed successfully!"
        
	fi
	
	else
        
		echo "ExifTool appears to be installed and is working properly, continuing..." | tee -a ~/Projects/CS225/exiftool.log
		fi

	fi
    	
# Removing the exiftool:

if [ ${1} == REMOVE ] ;then

	logger "Removing the exiftool using the ${0} script."
    
	echo "Removing ExifTool..." | tee -a ~/Projects/CS225/exiftool.log
	
	UNINSTALL=$(mktemp)
	cd ${TMP1}/${ExifVer}/
	
	make uninstall | grep -i unlink > ${UNINSTALL}
    
	. ${UNINSTALL}
	
	cd ~
	
	rm -rf ${TMP1}
	rm -f ${UNINSTALL}
fi

} 2>>~/Projects/CS225/exiftool.log


#CheckDirectory()
#{

#	if [ ! -d "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}" ] ;then
#        	mkdir -p "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}"
#	fi

#}

#copyfiles()
#{

#        cp $LINE "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}"

#}

#movefiles()
#{

#	 mv $LINE "${DIRECTORY}/${YEAR}/${MONTH}/${DAY}"

#}

#GetTimeStamp()
#{

#		TMP=$(stat --format '%y' "$LINE")
#                TMP=${TMP%%' '*}
#                YEAR=${TMP%%-*}
#                TMP=${TMP#*-}
#                MONTH=${TMP%%-*}
#                TMP=${TMP#*-}
#                DAY=${TMP%%-*}

#}

#2014-8-24_8-30-16_Canon-S80_2.jpg
#CheckCameraMakeModelDT()
#{
#TMP1=${File_Name}
#TMP2=${Create_Date}
#TMP3=${Camera_Model}
#TMP4=${Camera_Make}

#exiftool -t | grep File | awk '{ print $3 }' | grep .jpg =$File_Name
#exiftool -t | grep Create |  awk '{ print $3,$4 }' =$Create_Date
#exiftool -t | grep Camera | awk '/Name/{ print $4 }' =$Camera_Model
#exiftool -t | grep Make | awk '{ print $2 }' =$Camera_Make

#TMP6=${Video_File_Name}
#TMP7=${Video_Date_Time}

#exiftool -t | grep File | awk '{ print $3 }' | grep '.AVI\|.mts' =$Video_File_Name
#exiftool -t | grep Date/Time | awk '/Original/{ print $3,$4 }' | sed 's/......$//' =$Video_Date_Time

#}

CreateDirectory()
{

	DestinationDIR="/root/Projects/CS225/finalfiles/$Year/$Month/$Day"
	mkdir -p $DestinationDIR
	DEST=$DestinationDIR/$FileName

}


EXIV2()
{

	CameraMake=$(exiv2 "$FILE" | grep -a "make" | cut -f2 -d ":")
	CameraMake=${CameraMake# }
	CameraMake=${CameraMake// /-}
	CameraModel=$(exiv2 "$FILE" | grep -a "model" | cut -f2 -d ":")
	CameraModel=${CameraModel# }
	CameraModel=${CameraModel// /-}
	Year=$(exiv2 "$FILE" | grep -a "timestamp" | cut -f2 -d ":")
	Year=${Year# }
	Month=$(exiv2 "$FILE" | grep -a "timestamp" | cut -f3 -d ":")
	DayHour=$(exiv2 "$FILE" | grep -a "timestamp" | cut -f4 -d ":")
	Day=${DayHour%% *}
	Hour=${DayHour#* }
	Minute=$(exiv2 "$FILE" | grep -a "timestamp" | cut -f5 -d ":")
	Seconds=$(exiv2 "$FILE" | grep -a "timestamp" | cut -f6 -d ":")

if [[ "$FILE" == *.JPG ]] ;then
	
	FileType="jpg"

else

	FileType=${FILE#*.}

fi

if [[ "$CameraModel" =~ "$CameraMake" ]] ;then

        Camera="$CameraModel"
else

        Camera="$CameraMake-$CameraModel"

fi

	FileName="$Year"-"$Month"-"$Day"_"$Hour"-"$Minute"-"$Seconds"_"$Camera".$FileType

}


TIME()
{

	Camera="Unknown"
	Year=$(date +%Y -r $FILE)
	Month=$(date +%m -r $FILE)
	Day=$(date +%d -r $FILE)
	Hour=$(date +%H -r $FILE)
	Minute=$(date +%M -r $FILE)
	Seconds=$(date +%S -r $FILE)
	FileType=${FILE#*.}
	FileName="$Year"-"$Month"-"$Day"_"$Hour"-"$Minute"-"$Seconds"_"$Camera".$FileType

}

TMP_MD5SUM()
{

	md5=$(md5sum $FILE)
	md5=${md5%% *}

if grep "$md5" "$TMPS" ;then
  
	Duplicate=1

	if [[ "$DEST" == *.jpg ]] ;then
    	
	(( PictureDuplicate++ ))
	
	else
    	
	(( VideoDuplicate++ ))

	fi

else

  	(( PostFix++ ))

	FileName="$Year"-"$Month"-"$Day"_"$Hour"-"$Minute"-"$Seconds"_"$Camera"-"$PostFix".$FileType
  
	DEST=$DestinationDIR/$FileName

fi

}

FilesCopyingMoving()
{

	echo $(md5sum $FILE) >> $TMPS

if [[ "$DEST" == *.jpg ]] ;then
  	
	(( PictureCounter++ ))

else

  	(( VideoCounter++ ))

fi

if [[ ! -z "$FORCE" ]] ;then
	
	mv $FILE $DEST

	echo "Moved $Sort of $FileCount - $FILE to $DEST"

else

	cp $FILE $DEST

	echo "Copied $Sort of $FileCount - $FILE to $DEST"
fi

}

Summary()
{

if [[ ! -z "$FORCE" ]] ;then
 
	ITEM="moved"

else

	ITEM="copied"

fi

echo "$PictureCounter JPEGs $ITEM"
echo "$PictureDuplicate duplicate JPEGs not $ITEM"
echo "$VideoCounter videos $ITEM"
echo "$VideoDuplicate duplicate videos not $ITEM"

}

#NoSorting()
#{
#	echo "Media files sorting stopped"
	
#	cleanup

#	
#}

#TRAP_C()
#{

#	echo "   Please wait for the script to finish renaming/copying/moving!"

#}

TRAP_T()
{

	echo "   OK, Reverting the changes, please wait..."

	if_Exif REMOVE

	if_Exiftool REMOVE

	cleanup

	exit 1

}

cleanup()
{
        # removes TMP files

#       rm -Rf $TMP
#	rm -Rf $TMP1
#	rm -Rf $TMP2
#	rm -Rf $TMP3
#	rm -Rf $TMP4
#	rm -RF $TMP5
#	rm -Rf $TMP6
#	rm -Rf $TMP7

	rm -Rf $TMPS

	echo "Cleaned up TMP files"

}

trapCleanup()
{
	
	echo "   You didn't wait for the script to finish renaming/copying/moving!"
	
	echo "   Clean up in progress....."

	rm -Rf $TMPS

	echo "   Cleaned up TMP files"

	exit 1

}


#Error()
#{

#	logger "ctrl+c"

#}


TARUNZIP()
{
        cd /root/Projects/CS225
        tar -xzf /root/Projects/CS225/finalfiles.tar.gz
}


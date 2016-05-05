#!/bin/bash

while getopts :dvhn:l: opt ;do

   case $opt in
	d) set -x ;;
	v) VERBOSE=true
	echo "VERBOSE is set true" ;;
	h) echo "Your options in $0 are:
	 -d turns on debugging
	 -v sets the VERBOSE variable to true
	 -h Help
	 -n Entering a Name
	 -l List a DIR (Directory required)" ;;
	n) ARG=$OPTARG 
	echo "$ARG is the name entered" ;;
	l) DIR=$OPTARG
	if [[  -z $DIR ]] ;then
		echo "Please enter a path to a directory"
	fi
	echo "Would you like to view $DIR (Y or N)" 
	read ANS
		if [[ $ANS =~ [Yy][Ee]?[Ss]? ]] ;then
			ls $DIR/*
		else
			echo "Thanks for using my script"
			exit 1
		fi ;; 	
	\?) echo "Your options in $0 are:
         -d turns on debugging
         -v sets the VERBOSE variable to true
         -h Help
         -n Entering a Name
         -l List a DIR (Directory required)" ;;
   esac
done
shift $(($OPTIND -1))

if [[ -z $1 ]] ;then
:
else
echo $1
fi

if [[ -z $2 ]] ;then
:
else
echo $2
fi

if [[ -z $3 ]] ;then
:
else
echo $3
fi

if [[ -z $4 ]] ;then
:
else
echo $4
fi




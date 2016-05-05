#!/bin/bash

while getopts :dha:x opt ;do

   case $opt in
	d) set -x ;;
	h) echo "Syntax: $0" ;;
	a) ARGUMENT="$OPTARG" ;;
	x) VAR=value ;; 	
	\?) echo "Unknown option" ;;
   esac
done
shift $(($OPTIND -1))

echo "Arg is $ARGUMENT"

#var=bob
#   case $var in
#	bob) echo bob ;;
#	ted) echo ted ;;
#	sally) echo sally ;;
#   esac

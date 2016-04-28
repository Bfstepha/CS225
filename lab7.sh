#!/bin/bash

shopt -s extglob

path=$1

if [[ -z $path ]]
then
	echo "Try basename --help for help"
	exit
elif	[[ $path == / ]] ;then
	echo "/"
	exit
fi

path=${path%%+(/)}
filepath=${path##*/}

echo " $filepath "

#if [[ -z $filepath ]] ;then
#	path=${path%/*}
#	filepath=${path##*/}
#	echo "$filepath"
#else
#	echo "$filepath"
#fi

#basename ${VAR##*\/}}

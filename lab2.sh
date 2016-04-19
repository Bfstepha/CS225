#!/bin/bash

echo "Please enter an number"
read NUMBER

NUMBER=$(echo $NUMBER |  sed 's/^[-0]*//')

if [[ $NUMBER =~ ^[+]?[-]?[-0-9]+$ ]] ;then

	rem=$(( $NUMBER % 2 ))
 
	if [ $rem -eq 0 ]; then
    
		echo "Number is even"
	
	else
	
		echo "Number is odd"
	
	fi
else
	echo "Enter an number please"

fi

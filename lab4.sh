#!/bin/bash

echo "Please enter a number"
read NUMBER

if [[ $NUMBER =~ ^[-0-9]+$ ]] ;then 

	if  [[ $NUMBER -lt 50 || $NUMBER -gt 100 ]] ;then
    
		echo "Your number is out of the range"
	
	else
	
		echo "Your number is in the range"
	

	fi

else

	echo "Please enter a number"

fi

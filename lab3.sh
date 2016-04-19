#!/bin/bash

if [ $(whoami) = 'root' ] ;then

	echo "You must be another user to run this script"

	exit 1
else
	if [ $(id -u) -gt 500 ] ;then
	
		echo "Your username's id is $(id -u)"		

		if grep -q $(whoami) /etc/passwd ;then

		echo "$(whoami) 's home directory exists and is readable"
		
		cat /etc/passwd | grep "$(whoami)" | cut -f6 -d:

		echo "Your username's home directory is $(du -sh ~ | awk -F' ' '{ print $1 } ') in size."
			
		else

        	echo "Your username's home directory doesn't exist or isn't readable"
	
		fi
	else
	
	echo "You must be another user to run this script"
	echo "Your username's id is $(id -u) and is less than 500"

	fi

fi 


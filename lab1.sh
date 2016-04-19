#!/bin/bash

echo "Please enter an number"
read NUMBER

if [[ $NUMBER -gt 5 ]] ;then
	echo "Your number is greater than 5"

elif [[ $NUMBER -eq 5 ]]; then
	echo "Your number is equal to 5"

else
	echo "Your number is not greater than 5"

fi

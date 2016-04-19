#!/bin/bash

#echo "Hello World"

#VAR="Hello"

#echo "$VAR"

#echo $1

#VAR="$1"

#echo "${VAR}"


#echo "Enter Your Name"
#read NAME

#echo "Hello ${NAME}"

#FILE="$(cat /etc/passwd)"

#USERNAME="$(whoami)"

echo "Please enter your name"
read NAME

if [[ "$NAME" = 'bob' ]] ;then
	echo "Hello bob"
else
	echo "I don't know you"
fi

if grep root /etc/passwd ; then
	echo "root is there"
else
	echo "root isn't"

fi



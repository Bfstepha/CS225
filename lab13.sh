#!/bin/bash

trap "controlctrap" SIGINT

controlctrap()
{

	echo -e "   \e[1mNice try in trying to kill my script\e[0m"
	echo "   Exiting...."
	exit

}

echo "Please enter your information"
read INFO

if [[ -z $INFO ]] ;then
	
	echo -e "\e[0;31mPlease enter your information next time\e[0m"
	echo -e "\e[0;32mThank you\e[0m"
	
	exit

fi


#ip address
check_ip ()
{

IP=$1
 
	if [[ $IP =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])$ ]]
	
	then
		return "0"
	else 
		return "1"
	fi

}


#social security number
check_ssn()
{

SSN=$1

	if [[ $SSN =~ ^([0-9][0-9][0-9])[-' ']?([0-9][0-9])[-' ']?([0-9][0-9][0-9][0-9])$ ]]
	
	then
		return "0"
	else
		return "1"
	fi

}


#phone number
check_pn()
{

PN=$1

	if [[ $PN =~ ^([1-9][0-9][0-9][-' ']?[0-9][0-9][0-9][-' ']?[0-9][0-9][0-9][0-9])$ ]]

	then
		return "0"
	else 
		return "1"
	fi 

}


#credit card number
check_ccn()
{

CCN=$1

	if [[ $CCN =~ ^([0-9][0-9][0-9][0-9])[-' ']?([0-9][0-9][0-9][0-9])[-' ']?([0-9][0-9][0-9][0-9])$ ]]
	
	then
		return "0"
	else
		return "1"
	fi

}

if check_ip "$INFO" ;then

	echo -e "\e[0;94m$INFO\e[0m is a \e[0;32mVALID\e[0m IP address"
else
	echo -e "\e[0;94m$INFO\e[0m is an \e[0;31mINVALID\e[0m IP address"
fi

if check_ssn "$INFO" ;then

	echo -e "\e[0;94m$INFO\e[0m is a \e[0;32mVALID\e[0m Social Security number"
else
        echo -e "\e[0;94m$INFO\e[0m is an \e[0;31mINVALID\e[0m Social Security number"
fi

if check_pn "$INFO" ;then

	echo -e "\e[0;94m$INFO\e[0m is a \e[0;32mVALID\e[0m Phone number"
else
        echo -e "\e[0;94m$INFO\e[0m is an \e[0;31mINVALID\e[0m Phone number"
fi

if check_ccn "$INFO" ;then

	echo -e "\e[0;94m$INFO\e[0m is a \e[0;32mVALID\e[0m Credit Card number"
else
	echo -e "\e[0;94m$INFO\e[0m is an \e[0;31mINVALID\e[0m Credit Card number"
fi


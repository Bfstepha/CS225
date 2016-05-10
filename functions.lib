#!/bin/bash

#trap "echo Goodbye" EXIT

#echo $VAR1

#==========================================

#trap "echo I\'m sorry Dave" SIGINT

#while true ;do
#     sleep 1
#done

#==========================================

#trap "echo I\'m sorry Dave" SIGINT

#	cp /etc/passwd /tmp &
#	cp /etc/passwd /tmp &
#	cp /etc/passwd /tmp &
#	cp /etc/passwd /tmp &
#	wait

#==========================================

#trap "echo I\'m sorry Dave" SIGINT

#cleanup()
#{
#	rm -Rf $TMP
#}

#test()
#{
#	local FIRSTVAR="$VAR"
#	echo "$FIRSTVAR"

#	#local FIRSTVAR="$1"
#	#echo "\$1 is $1"


#}

#VAR="five"

###GLOBAL=$(test)
#test

##test five
##echo "\$1 is $1"


###cleanup_tmp()

#cleanup


cleanup()
{
	# removes tmpdir
	rm -Rf $TMPDIR
	exit
}

trap "cleanup" SIGINT

# set vars

TMPDIR=$(mktemp -d)


test()
{
	# Expects a number
	# Outputs a letter
	VAR=$1
	echo $VAR

}

#!/bin/sh

# Set "base" to the desired prefix
base="loaner-"

# Grab the computer's serial number
serial=`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`

# Set the name to a+b
/usr/sbin/scutil --set ComputerName $base$serial


exit 0		## Success
exit 1		## Failure

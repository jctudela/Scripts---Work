#!/bin/sh

#Define current user
current_user=`ls -l /dev/console | awk '{print $3}'`

#Define whether computer is a laptop or a desktop
IS_LAPTOP=`/usr/sbin/system_profiler SPHardwareDataType | grep "Model Identifier" | grep "Book"`

#Based on this, it will rename the computer accordingly
if [ "$IS_LAPTOP" != "" ]; then
	/usr/sbin/scutil --set ComputerName laptopfac-$current_user
else	
	/usr/sbin/scutil --set ComputerName desktopfac-$current_user
fi

#Now send heartbeat to AM
/Library/Application Support/LANrev Agent/LANrev Agent.app/Contents/MacOS/LANrev Agent --SendHeartbeat

###Wrap this with a nice LaunchD item that runs on an interval

exit 0		## Success
exit 1		## Failure

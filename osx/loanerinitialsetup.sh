#!/bin/sh

#initial setup for loaners
#OCADU 2015

#removing any parental controls/unnecessary control policies from guest account

dscl . -mcxdelete Users/Guest
rm -f /Library/Managed\ Preferences/Guest/com.apple.familycontrols.contentfilter.plist

#Disable "Remember this network" for Airport

/usr/libexec/airportd prefs RememberRecentNetworks=NO

#remove annoying Adobe Creative Cloud app launch on startup

rm -f /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist


#make a symbolic link from /System/Library/CoreServices/Applications/Directory Utility.app 
#to /Applications/Utilities so that Directory Utility.app is easier to access.

if [[ ! -e "/Applications/Utilities/Directory Utility.app" ]]; then
   ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
fi

if [[ -L "/Applications/Utilities/Directory Utility.app" ]]; then
   rm "/Applications/Utilities/Directory Utility.app"
   ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
fi

#make a symbolic link from /System/Library/CoreServices/Applications/Network Utility.app 
#to /Applications/Utilities so that Network Utility.app is easier to access.

if [[ ! -e "/Applications/Utilities/Network Utility.app" ]]; then
   ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
fi

if [[ -L "/Applications/Utilities/Network Utility.app" ]]; then
   rm "/Applications/Utilities/Network Utility.app"
   ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
fi

#make a symbolic link from /System/Library/CoreServices/Applications/Wireless Diagnostics.app 
#to /Applications/Utilities so that Wireless Diagnostics.app is easier to access.

if [[ ! -e "/Applications/Utilities/Screen Sharing.app" ]]; then
   ln -s "/System/Library/CoreServices/Applications/Wireless Diagnostics.app" "/Applications/Utilities/Screen Sharing.app"
fi

if [[ -L "/Applications/Utilities/Screen Sharing.app" ]]; then
   rm "/Applications/Utilities/Screen Sharing.app"
   ln -s "/System/Library/CoreServices/Applications/Wireless Diagnostics.app" "/Applications/Utilities/Screen Sharing.app"
fi

#set power settings for loaners, 180 mins for sleep, 60 mins for display sleep

pmset sleep 180 disksleep 0 displaysleep 60 halfdim 1

#turn SSH on

systemsetup -setremotelogin on

#turn off Gatekeeper

spctl --master-disable

#Remove setup LaunchDaemon

srm /Library/LaunchDaemons/com.ocadu.loanerinitialsetup.plist

#Self-Destruct

srm $0

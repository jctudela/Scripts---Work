#!/bin/sh

# Configure Finder to use Column View

defaults write /System/Library/User\ Template/English.lproj/Library/Preferences/com.apple.finder "AlwaysOpenWindowsInColumnView" -bool true

# Configure network time server and region

# Set the time zone

# /usr/sbin/systemsetup -settimezone $TimeZone

# Disable root login by setting root's shell to /usr/bin/false

# dscl . -create /Users/root UserShell /usr/bin/false

# Make a symbolic link from /System/Library/CoreServices/Directory Utility.app 
# to /Applications/Utilities so that Directory Utility.app is easier to access.

ln -s /System/Library/CoreServices/Directory\ Utility.app /Applications/Utilities/Directory\ Utility.app

# Set separate power management settings for desktops and laptops
# If it's a laptop, the power management settings for "Battery" are set to have the computer sleep in 15 minutes, disk will spin down 
# in 10 minutes, the display will sleep in 5 minutes and the display itslef will dim to half-brightness before sleeping. While plugged 
# into the AC adapter, the power management settings for "Charger" are set to have the computer never sleep, the disk doesn't spin down, 
# the display sleeps after 30 minutes and the display dims before sleeping.
# 
# If it's not a laptop (i.e. a desktop), the power management settings are set to have the computer never sleep, the disk doesn't spin down, the display 
# sleeps after 30 minutes and the display dims before sleeping.
#

# Detects if this Mac is a laptop or not by checking the model ID for the word "Book" in the name.

IS_LAPTOP=`/usr/sbin/system_profiler SPHardwareDataType | grep "Model Identifier" | grep "Book"`

if [ "$IS_LAPTOP" != "" ]; then
	pmset -b sleep 15 disksleep 10 displaysleep 5 halfdim 1
	pmset -c sleep 0 disksleep 0 displaysleep 30 halfdim 1
else	
	pmset sleep 0 disksleep 0 displaysleep 30 halfdim 1
fi

# Set the login window to name and password

defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true
defaults write /Library/Preferences/com.apple.loginwindow EnableExternalAccounts -bool false

# Set the ability to  view additional system info at the Login window
# The following will be reported when you click on the time display 
# (click on the time again to proceed to the next item):
#
# Computer name
# Version of OS X installed
# IP address
# This will remain visible for 60 seconds.

defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disables iCloud pop-up on first login for Macs

for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion 10.8
  done

for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then 
      if [ ! -d "${USER_HOME}"/Library/Preferences ]
      then
        mkdir -p "${USER_HOME}"/Library/Preferences
        chown "${USER_UID}" "${USER_HOME}"/Library
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ -d "${USER_HOME}"/Library/Preferences ]
      then
        defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
        defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
        defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion 10.8
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist
      fi
    fi
  done

# Turn SSH on

systemsetup -setremotelogin on

# Turn off Gatekeeper

spctl --master-disable 

# Remove the loginwindow delay by loading the com.apple.loginwindow   
# LaunchDaemon in /System/Library/LaunchDaemons/

launchctl load /System/Library/LaunchDaemons/com.apple.loginwindow.plist

# Turn off Notification Centre

defaults write /System/Library/LaunchAgents/com.apple.notificationcenterui KeepAlive -bool false

#Sets HostName of the Machine
#scutil --set HostName %SerialNumber%
#scutil --set ComputerName %SerialNumber%

srm $0

exit 0

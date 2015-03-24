#!/bin/sh

# Removing ALL configuration profiles

/usr/bin/profiles -D -f

#Turning Airport off/on and make sure service is enabled

networksetup -setairportpower Wi-Fi off; networksetup -setairportpower Wi-Fi on
networksetup -setnetworkserviceenabled Wi-Fi on

#Disable "Remember this network" for Airport

/usr/libexec/airportd prefs RememberRecentNetworks=NO
#Setting power to never sleep

pmset sleep 0 disksleep 0 displaysleep 0 halfdim 0

#Disabling Blueooth from nagging if keyboard/mouse are not found

defaults write /Library/Preferences/com.apple.Bluetooth.plist BluetoothAutoSeekKeyboard 0
defaults write /Library/Preferences/com.apple.Bluetooth.plist BluetoothAutoSeekPointingDevice 0

#Set auto login for GradEx user
defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser "gradex"

#Disable Screensaver
#First grab the system's uuid
if [[ `ioreg -rd1 -c IOPlatformExpertDevice | grep -i "UUID" | cut -c27-50` != "00000000-0000-1000-8000-" ]]; then
    macUUID=`ioreg -rd1 -c IOPlatformExpertDevice | grep -i "UUID" | cut -c27-62`
fi
#Then write to the respective plist
defaults write /Users/gradex/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist CleanExit "YES"
defaults write /Users/gradex/Library/Preferences/ByHost/com.apple.screensaver.$macUUID.plist idleTime -int 0
#Make sure permissions are correct
chown -R loaner /Users/gradex/Library/Preferences/ByHost
chmod -R 755 /Users/gradex/Library/Preferences/ByHost
#and because Mavericks is a jerk
sudo killall cfprefsd

exit 0

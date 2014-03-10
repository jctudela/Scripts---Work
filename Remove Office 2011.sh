#!/bin/sh

os=`sw_vers -productVersion | awk -F. '{print $1 "." $2}'`

rm -rf "/Applications/Microsoft Communicator.app"
rm -rf "/Applications/Microsoft Messenger.app"
rm -rf "/Applications/Microsoft Office 2011"
rm -rf "/Applications/Remote Desktop Connection.app"
rm -rf "/Library/Fonts/Microsoft"
rm -rf "/Library/Internet Plug-Ins/OfficeLiveBrowserPlugin.plugin"
rm -rf "/Library/Application Support/Microsoft/Communicator"
rm -rf "/Library/Application Support/Microsoft/MAU2.0"
rm -rf "/Library/Application Support/Microsoft/MERP2.0"
rm "/Library/Preferences/com.microsoft.office.licensing.plist"
rm "/Library/LaunchDaemons/com.microsoft.office.licensing.helper.plist"
rm "/Library/PrivilegedHelperTools/com.microsoft.office.licensing.helper"

if [ $os = "10.6" ] || [ $os = "10.7" ]
 then rm -f "/var/db/receipts/com.microsoft.office*" "/var/db/receipts/com.microsoft.oc*" "/var/db/receipts/com.microsoft.mau*" "/var/db/receipts/com.microsoft.merp*"
 	else
 if [ $os = "10.5" ]
 then rm -rf "/Library/Receipts/Office2011_en_*"
 fi
fi
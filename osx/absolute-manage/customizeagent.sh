#!/bin/sh

#This will assist configuring AM agents beyond the very basic configuration included with the agent

#Enable remote
defaults write /Library/Preferences/com.poleposition-sw.lanrev_agent.plist AbsoluteRemoteEnabled true

#Specify password for remote
defaults write /Library/Preferences/com.poleposition-sw.lanrev_agent.plist AbsoluteRemotePassword 11686D64AACB64A3CC8775639F308742BBB3C479B42CCFA14B

#Specify port for remote
defaults write /Library/Preferences/com.poleposition-sw.lanrev_agent.plist AbsoluteRemotePort 5901

#No user confirmation required for remote
defaults write /Library/Preferences/com.poleposition-sw.lanrev_agent.plist AbsoluteRemoteUserConfirmationRequired false

#Check for Apple Software Updates
defaults write /Library/Preferences/com.poleposition-sw.lanrev_agent.plist CheckAppleSoftwarePatches true

#Check for Third-party patches
defaults write /Library/Preferences/com.poleposition-sw.lanrev_agent.plist CheckThirdPartySoftwarePatches true

#####ENTER MORE UPON TESTING####

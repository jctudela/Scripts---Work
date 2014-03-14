#!/bin/sh

#Obtain Custom Agent Name
AGENT_NAME=`defaults read /Library/Preferences/com.poleposition-sw.lanrev_agent.plist | grep -w CustomAgentName | awk '{print $3}'`

#Sets HostName of the Machine

scutil --set HostName $AGENT_NAME
scutil --set ComputerName $AGENT_NAME

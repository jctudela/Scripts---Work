#!/bin/sh

# Get the Active Directory Node Name
###
adNodeName=/Active\ Directory/Domain/FQDN

###
# Get the Domain Users groups Numeric ID
###
domainUsersPrimaryGroupID=`dscl /Search read /Groups/Domain\ Users | grep PrimaryGroupID | awk '{ print $2}'`

###
# Gets the unique ID of the Users account locally, if that fails performs a lookup
###
  uniqueID () 
{		
		# Attempt to query the local directory for the users UniqueID
		accountUniqueID=`dscl . -read /Users/$1 2>/dev/null | ﻿grep UniqueID | cut -c 11-`
		
		# If no value recived for the Users account, attempt a lookup on the domain
		if [ -z "$accountUniqueID" ]; then
					echo "Account is not on this mac..."
					accountUniqueID=`dscl "$adNodeName" -read /Users/$1 2>/dev/null | grep UniqueID | awk '{ print $2}'`
		fi
}

###
# Sets IFS to newline
###
IFS=$'\n'

###
# Returns a list of all folders found under /Users
###
for userFolders in `ls -d -1 /Users/* | cut -c 8- | sed -e 's/ /\\ /g' | grep -v "Shared"`

do
	# Return folder name found in /Users/
	echo "$userFolders..."
	# Check to see if folders contain a /Desktop folder, if they do assume it's a Home Folder
	if [ -d /Users/"$userFolders"/Desktop ]; then
	
		# Pass $userFolders to function uniqueID
		uniqueID "$userFolders"
		echo "User $userFolders's UniqueID = $accountUniqueID..."
		
		### The below is well echoed so should be explanatory ###
		
		if [ -z "$accountUniqueID" ]; then

			echo "Account is not local & cannot be found on $adNodeName... "
			echo "Removing all ACL's from /Users/$userFolders/ Account..."	
			sudo chmod -R -N /Users/$userFolders
			
			echo "Clearing locks on any locked files/folder found in /Users/$userFolders/..."
			sudo chflags -R nouchg /Users/$userFolders
			
			echo "Making /Users/$userFolders/ fully accessible to all..."
			sudo chmod -R 777 /Users/$userFolders
			
		else
			
			echo "Removing all ACL's from /Users/$userFolders/ Account..."	
			sudo chmod -R -N /Users/$userFolders
			
			echo "Clearing locks on any locked files/folder found in /Users/$userFolders/..."
			sudo chflags -R nouchg /Users/$userFolders
			
				if [ 1000 -gt "$accountUniqueID" ]; then
					echo "$accountUniqueID is a local account..."
					echo "As local account, setting Owners to $accountUniqueID:staff..."
					sudo chown -R $accountUniqueID:staff /Users/$userFolders/
				else
					echo "User $userFolders is a Domain account..."
					echo "$domainUsersPrimaryGroupID is the ID for the Domain Users group..."
					echo "As domain account, setting Owners to $accountUniqueID:$domainUsersPrimaryGroupID..."
					sudo chown -R $accountUniqueID:$domainUsersPrimaryGroupID /Users/$userFolders
				fi
				
			echo "Setting rwxr--r-- permission for Owner, Read for Everyone for everything under /Users/$userFolders..."
			sudo chmod -R 755 /Users/$userFolders/
			
			if [ -d /Users/$userFolders/Desktop/ ]; then
				echo "Setting rwx permission for Owner, None for Everyone for /Users/$userFolders/Desktop..."
				sudo chmod 700 /Users/$userFolders/Desktop/
			fi
			
			if [ -d /Users/$userFolders/Documents/ ]; then
				echo "Setting rwx permission for Owner, None for Everyone for /Users/$userFolders/Documents..."
				sudo chmod 700 /Users/$userFolders/Documents/
			fi
			
			if [ -d /Users/$userFolders/Downloads/ ]; then
				echo "Setting rwx permission for Owner, None for Everyone for /Users/$userFolders/Downloads..."
				sudo chmod 700 /Users/$userFolders/Downloads/
			fi
			
			if [ -d /Users/$userFolders/Library/ ]; then
				echo "Setting rwx permission for Owner, None for Everyone for /Users/$userFolders/Library..."
				sudo chmod 700 /Users/$userFolders/Library/
			fi
			
			if [ -d /Users/$userFolders/Movies/ ]; then
				echo "Setting rwx permission for Owner, None for Everyone for /Users/$userFolders/Movies..."
				sudo chmod 700 /Users/$userFolders/Movies/
			fi
			
			if [ -d /Users/$userFolders/Music/ ]; then
				echo "Setting rwx permission for Owner, None for Everyone for /Users/$userFolders/Music..."
				sudo chmod 700 /Users/$userFolders/Music/
			fi
			
			if [ -d /Users/$userFolders/Pictures/ ]; then
				echo "Setting rwx permission for Owner, None for Everyone for /Users/$userFolders/Pictures..."
				sudo chmod 700 /Users/$userFolders/Pictures/
			fi
				
				# If the Public folder exists in /Users/$userFolders/, give it it's special permissions
				if [ -d /Users/$userFolders/Public/ ]; then
					echo "Setting Read only access for Everyone to /Users/$userFolders/Public/..."
					sudo chmod -R 755 /Users/$userFolders/Public
						# If the Drop Box folder exists in /Users/$userFolders/, give it it's special permissions
						if [ -d /Users/$userFolders/Public/Drop\ Box/ ]; then
							echo "Drop Box folder found, setting Write only access for Everyone to /Users/$userFolders/Public/Drop Box/..."
							sudo chmod -R 733 /Users/$userFolders/Public/Drop\ Box/
						fi
				else
				# Notify if not found
					echo "Public folder not found @ /Users/$userFolders/Public/..."
				fi
					
				# If the Sites folder exists in /Users/$userFolders/, give it it's special permissions
				if [ -d /Users/$userFolders/Sites/ ]; then
					echo "Setting Read only access for Everyone to /Users/$userFolders/Public/..."
					sudo chmod -R 755 /Users/$userFolders/Public
				else
				# Notify if not found
					echo "Sites folder not found @ /Users/$userFolders/Sites/..."
				fi
			fi
			#Creates a new line in the output, making it more readable
			echo ""
	else
		echo "No Desktop folder in /Users/$userFolders/.. Setting rwx for all to /Users/$userFolders/..."
		sudo chmod -R 777 /Users/$userFolders/
	fi
	
done

###
# Resets IFS
###
unset IFS

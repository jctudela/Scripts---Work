#!/bin/sh

# Define current user
current_user=`ls -l /dev/console | awk '{print $3}'`

# Loop through users with homes in /Users;
# exclude any accounts you don't want removed
# (i.e. local admin and current user if script runs
# while someone is logged in)

for dir in `find /Users/* -mtime +45 -type d -name [a-z][a-z][0-9][0-9][a-z][a-z] | grep -v '$current_user'`
do
 echo "Removing user: $dir"
 dscl . delete $dir
 rm -rf $dir
done
# End of script

#!/bin/sh

# Sets the default user to a specific user account

cp "${DS_REPOSITORY_PATH}"/Files/Mac\ OS/kcpassword /Volumes/"${DS_LAST_RESTORED_VOLUME}"/etc/

defaults write /Volumes/"${DS_LAST_RESTORED_VOLUME}"/Library/Preferences/com.apple.loginwindow autoLoginUser "loaner"
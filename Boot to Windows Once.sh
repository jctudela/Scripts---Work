#!/bin/sh
# tell OSX to change the boot disk 
# nextonly just for the next time - without the default would be Windows
/usr/sbin/bless --device /dev/disk0s3 --setBoot --legacy --nextonly
# reboot
/sbin/shutdown -r now
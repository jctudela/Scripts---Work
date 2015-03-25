#!/bin/sh

#First, replace x and y values accordingly
oldserver="x"
newserver="y"


#Unbind from old OD server specified
/usr/sbin/dsconfigldap -r $oldserver
/usr/bin/dscl localhost -delete /Search CSPSearchPath /LDAPv3/$oldserver
/usr/bin/dscl localhost -delete /Contact CSPSearchPath /LDAPv3/$oldserver

#A few seconds to breathe
sleep 5

#Bind to the new OD server specified
/usr/sbin/dsconfigldap -a $newserver
/usr/bin/dscl localhost -create /Search SearchPolicy dsAttrTypeStandard:CSPSearchPath
/usr/bin/dscl localhost -merge /Search CSPSearchPath /LDAPv3/$newserver
/usr/bin/dscl localhost -create /Contact SearchPolicy dsAttrTypeStandard:CSPSearchPath
/usr/bin/dscl localhost -merge /Contact CSPSearchPath /LDAPv3/$newserver

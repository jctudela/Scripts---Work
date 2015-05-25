#!/bin/sh
#This is intended to force run all pending scripts from the DS
#local temp directory when imaging fails

SCRIPTSDIR='/private/etc/deploystudio/scripts'

if [[ -d "${SCRIPTSDIR}" && ! -L "${SCRIPTSDIR}" ]] ; then

  cd $SCRIPTSDIR/$1

  IFS="$(printf '\n\t')"   # Remove space.

  #  Correct glob use:
  #  Always use for-loop, prefix glob, check if exists file.
  
  for file in ./* ; do         # Use ./* ... NEVER bare *
    if [ -e "$file" ] ; then   # Check whether file exists.
     ./$file
    fi
  done


else
    echo $1 "is not a directory"
    exit 2
fi

exit 0

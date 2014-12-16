#!/bin/bash
# @author: SENOO, Ken
# (Last Update: 2014-12-16T16:28+09:00)

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

windir=".atom tecplot.cfg"
homefile="tecplot.cfg"
for dotfile in ${script_dir}/{.??*,$homefile}
do
  if [ "$OS" == "Windows_NT" ]; then
    for winconf in $windir
    do
      if echo $dotfile | grep -q $winconf; then
        ln -sfd $dotfile $USERPROFILE/
      fi
    done
  else
    ln -sfd  $dotfile  ~/
  fi
done

#!/bin/bash
# @author: SENOO, Ken
# (Last Update: 2014-11-23T19:14+09:00)

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

for dotfile in ${script_dir}/.??*
do
  if [ $OS == "Windows_NT" ] && echo $dotfile | grep -q atom ; then
    ln -sfd $dotfile $USERPROFILE/
  else
    ln -sfd  $dotfile  ~/
  fi
done

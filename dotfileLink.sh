#!/bin/bash
# @author: SENOO, Ken
# (Last Update: 2014-11-17T10:27+09:00)

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

for dotfile in ${script_dir}/.??*
do
  if [ $OS == "Windows_NT" ]; then
    case $dotfile in
      *.atom*) ln -sfd $dotfile $USERPROFILE/
    esac
  fi
  ln -sfd  $dotfile  ~/
done

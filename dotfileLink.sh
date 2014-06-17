#!/bin/sh
# @author: SENOO, Ken
# (Last Update: 2014-05-06T22:27+09:00)

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

for dotfile in ${script_dir}/.??*
do 
    if [ $dotfile != '.git' ]
    then
        ln -sfd  $dotfile  ~/
    fi
done

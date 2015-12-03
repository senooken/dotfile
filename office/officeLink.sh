#!/bin/sh
# @author: SENOO, Ken
# (Last Update: 2014-05-12T22:57+09:00)

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

for dotfile in ${script_dir}/soffice.*
do 
    if [ $dotfile != '.git' ]
    then
        ln -sf  $dotfile  ~/Templates/
    fi
done

#!/bin/bash
# @author: SENOO, Ken
# (Last Update: 2015-02-20T14:03+09:00)

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

windir=".atom tecplot.cfg"
homefile="tecplot.cfg"
# .で始まるファイルとhomefileで指定したファイルを対象
# windirで指定したファイルは$USERPROFILEにリンク
for dotfile in ${script_dir}/{.??*,$homefile}
do
  if [ "$OS" == "Windows_NT" ] && echo $windir | grep -q ${dotfile##*/}; then
        ln -sfd $dotfile $USERPROFILE/
  else
    ln -sfd  $dotfile  ~/
  fi
done

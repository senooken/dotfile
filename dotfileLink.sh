#!/bin/bash
# \file dotfileLink.sh
# \author SENOO, Ken

shopt -s dotglob
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

EXCLUDE=".git .gitmodule"

windir=".atom tecplot.cfg"
homefile="tecplot.cfg"
# .で始まるファイルとhomefileで指定したファイルを対象
# windirで指定したファイルは$USERPROFILEにリンク

if [ "$OS" == "Windows_NT" ]; then
  ln -sfd ${script_dir}/windows/* "${APPDATA}/"
  for dotfile in ${script_dir}/{.??*,$homefile}; do
    if [[ .*${windir} =~ ${dotfile##*/} ]]; then
      ln -sfd "$dotfile" "${USERPROFILE}/"
    elif [[ "${dotfile}" =~ .*mozc$ ]]; then
      dir="${USERPROFILE}/AppData/LocalLow/Google/Google Japanese Input/"
      mkdir -p "${dir}"
      ln -sfd ${dotfile}/* "${dir}"
    else
      ln -sfd  "${dotfile}"  ~/
    fi
  done
else
  ln -sfd ${script_dir}/linux/* ~/
  for dotfile in ${script_dir}/{.??*,$homefile}; do
    ln -sfd  "${dotfile}"  ~/
  done
fi

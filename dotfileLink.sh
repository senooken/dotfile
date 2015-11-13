#!/bin/bash
# \file dotfileLink.sh
# \author SENOO, Ken

shopt -s dotglob
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

EXCLUDE=".DS_Store .git .gitmodule"

windir=".atom tecplot.cfg"
homefile="tecplot.cfg"
# .で始まるファイルとhomefileで指定したファイルを対象
# windirで指定したファイルは$USERPROFILEにリンク

if [ "$OS" == "Windows_NT" ]; then
  ln -sfd ${script_dir}/windows/* "${APPDATA}/"
  for dotfile in ${script_dir}/{.??*,$homefile}; do
    [[ ${EXCLUDE} =~ .*${dotfile##*/}* ]] && continue
    # if [[ .*${windir}.* =~ ${dotfile##*/} ]]; then
    if [[ ${windir} =~ .*${dotfile##*/}* ]]; then
      ln -sfd "$dotfile" "${USERPROFILE}/"
    elif [[ "${dotfile}" =~ .*mozc$ ]]; then
      mkdir -p "${USERPROFILE}/AppData/LocalLow/Google/Google Japanese Input/"
      ln -sfd ${dotfile}/* "${dir}"
    else
      ln -sfd  "${dotfile}"  ~/
    fi
  done
else
  ln -sfd ${script_dir}/linux/* ~/
  for dotfile in ${script_dir}/{.??*,$homefile}; do
    [[ ${EXCLUDE} =~ .*${dotfile##*/}* ]] && continue
    ln -sfd  "${dotfile}"  ~/
  done
fi

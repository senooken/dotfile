#!/bin/bash
# \file dotfileLink.sh
# \author SENOO, Ken

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

windir=".atom tecplot.cfg"
homefile="tecplot.cfg"
# .で始まるファイルとhomefileで指定したファイルを対象
# windirで指定したファイルは$USERPROFILEにリンク
for dotfile in ${script_dir}/{.??*,$homefile}; do
  if [ "${OS}" != "Windows_NT" ]; then
    ln -sfd  "${dotfile}"  ~/
  elif [[ .*${windir} =~ ${dotfile##*/} ]]; then
    ln -sfd "$dotfile" "${USERPROFILE}/"
  elif [[ "${dotfile}" =~ .*mozc$ ]]; then
    ln -sfd "${dotfile}" "${USERPROFILE}/LocalLow/Google/Google Japanese Input"
  fi
done

if [ "$OS" == "Windows_NT" ]; then
  for dotfile in ${script_dir}/windows/*; do
    ln -sfd "${dotfile}" "${APPDATA}/"
  done
fi

if [ "$OS" != "Windows_NT" ]; then
  for dotfile in ${script_dir}/linux/.??*; do
    ln -sfd "${dotfile}" ~/
  done
fi

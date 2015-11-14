#!/bin/bash
# \file dotfileLink.sh
# \author SENOO, Ken
# \license CC0

shopt -s dotglob
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

EXCLUDE=".DS_Store .git .gitmodule"
[ "$OS" == "Windows_NT" ] && is_windows="TRUE" || is_windows=""

for dotfile in "${script_dir}"/.??*; do
  [[ ${EXCLUDE} =~ .*${dotfile##*/}* ]] && continue
  [ $is_windows ] && ln -sfd ${script_dir}/windows/* "${APPDATA}/"
  [ ! $is_windows ] && ln -sfd ${script_dir}/linux/* ~/
  ln -sfd  "${dotfile}"  ~/
done

## OS specific configuration
### mozilla系ソフトはプロファイル管理が特殊なので注意
for dotfile in ${script_dir}/specific/*; do
  basename="${dotfile##*/}"
  if [ $is_windows ] && [ "${basename}" == ".mozc" ]; then
    mkdir -p "${USERPROFILE}/AppData/LocalLow/Google/Google Japanese Input/"
    ln -sf ${dotfile}/* "${USERPROFILE}/AppData/LocalLow/Google/Google Japanese Input/"
  elif [ "${basename}" == '.disruptive innovations sarl' ]; then
    if [ $is_windows ]; then
      ln -sf "${dotfile}/bluegriffon/xxxxxxxx.defaullt/"* "${USERPROFILE}/AppData/Roaming/Disruptive Innovations SARL/BlueGriffon/Profiles/"*.default/
    else
      ln -sf "${dotfile}/bluegriffon/xxxxxxxx.defalut/"* "${HOME}/.disruptive innovations sarl/bluegriffon/"*.default/
    fi
  elif [ "$basename" == 'tecplot.cfg' ]; then
    [ $is_windows ] && ln -sf "$dotfile" "${USERPROFILE}/" || ln -sf "$dotfile" ~/
  elif [ $is_windows ] && [ "$basename" == ".atom" ]; then
    mkdir -p "${USERPROFILE}"/.atom && ln -sfd ${dotfile}/* "${USERPROFILE}/"
  elif [ "$basename" == "tecplot.cfg" ]; then
    [ $is_windows ] && ln -sf "${USERPROFILE}/"
    [ ! $is_windows ] && ln -sf ~/
  else
    mkdir -p "${basename}" ~/"${basename}"/
    ln -sfd "${dotfile}"/* ~/"$basename"/
  fi
done

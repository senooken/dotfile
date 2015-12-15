#!/bin/bash
## \file   dotfileLink.sh
# \author  SENOO, Ken
# \license CC0

function make_recursive_link(){
  dirname="${1%/*}"
  dest_dir="$2"
  find "$1" | while read target; do
    if [ -d "$target" ]; then
      mkdir -p "$dest_dir/${target##$dirname}"
    else
      ln -f "$target" "$dest_dir/${target##$dirname}"
    fi
  done
}

shopt -s dotglob
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

EXCLUDE=".DS_Store .git .gitmodule"
[ "$OS" == "Windows_NT" ] && is_windows="TRUE" || is_windows=""

## shared configuration
for dotfile in "${script_dir}"/.??*; do
  [[ ${EXCLUDE} =~ .*${dotfile##*/}* ]] && continue
  ln -sfd  "${dotfile}"  ~/
done

## OS specific configuration
if [ $is_windows ]; then
  for dotfile in "${script_dir}"/windows/*; do
    make_recursive_link $dotfile $APPDATA
  done
else
  for dotfile in "${script_dir}"/linux/*; do
    make_recursive_link $dotfile ~/
  done
fi

## shared special OS configuration
### mozilla系ソフトはプロファイル管理が特殊なので注意
for dotfile in ${script_dir}/specific/*; do
  basename="${dotfile##*/}"
  if [ $is_windows ] && [ "${basename}" == ".mozc" ]; then
    mkdir -p "${USERPROFILE}/AppData/LocalLow/Google/Google Japanese Input/"
    ln -f ${dotfile}/* "${USERPROFILE}/AppData/LocalLow/Google/Google Japanese Input/"
  elif [ "${basename}" == '.disruptive innovations sarl' ]; then
    if [ $is_windows ]; then
      ln -f "${dotfile}/bluegriffon/xxxxxxxx.default/"* "${USERPROFILE}/AppData/Roaming/Disruptive Innovations SARL/BlueGriffon/Profiles/"*.default/
    else
      ln -f "${dotfile}/bluegriffon/xxxxxxxx.default/"* "${HOME}/.disruptive innovations sarl/bluegriffon/"*.default/
    fi
  elif [ "$basename" == 'tecplot.cfg' ]; then
    [ $is_windows ] && ln -sf "$dotfile" "${USERPROFILE}/" || ln -sf "$dotfile" ~/
  elif [ $is_windows ] && [ "$basename" == ".atom" ]; then
    mkdir -p "${USERPROFILE}"/.atom && ln -f ${dotfile}/* "${USERPROFILE}/.atom/"
  elif [ "$basename" == "tecplot.cfg" ]; then
    [ $is_windows ] && ln -sf "${dotfile}" "${USERPROFILE}/"
    [ ! $is_windows ] && ln -sf "${dotfile}" ~/
  else
    mkdir -p  ~/"${basename}"/
    ln -f "${dotfile}"/* ~/"$basename"/
  fi
done

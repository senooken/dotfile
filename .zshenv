#####################################################################
#
#  Sample .zshenv file
#
#  initial setup file for both interactive and noninteractive zsh
#
#####################################################################

[[ $OSTYPE == cygwin* ]] || limit coredumpsize 0
# Setup command search path
typeset -U path
# (N-/) を付けることで存在しなければ無視してくれる
path=( /usr/*/bin(N-/) /usr/local/*/bin(N-/) /var/*/bin(N-/) /usr/bin /bin)

## local path
export PATH="${HOME}/local/bin:$PATH"
export MANPATH="${HOME}/local/man:$MANPATH"
export LD_LIBRARY_PATH="${HOME}/local/lib/:$LD_LIBRARY_PATH"
export INCLUDE="${HOME}/local/include:$INCLUDE"
export C_INCLUDE_PATH="${HOME}/local/include:$C_INCLUDE_PATH"
export CPATH="${HOME}/local/include:$CPATH"

## for python pip local installed package
export PATH=${HOME}/.local/bin:$PATH 
export MANPATH=${HOME}/.local/man:$MANPATH
export LD_LIBRARY_PATH=${HOME}/.local/lib:$LD_LIBRARY_PATH
export INCLUDE="${HOME}/.local/include:$INCLUDE"

zstyle ":completion:*:commands" rehash # update PATH when change
unsetopt cdablevars # invalid additional candidacy when cd completation

export WINEARCH=win32

# リモートから起動するコマンド用の環境変数を設定(必要なら)
export RSYNC_RSH=ssh
export CVS_RSH=ssh

export LANG=ja_JP.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_TIME=en_US.UTF-8

#case $TERM in
#    linux) LANG=C ;;
#    *) LANG=ja_JP.UTF-8 ;;
#esac

export CYGWIN="nodosfilewarning winsymlinks:native"
### binding keys
bindkey -e

#bindkey '^n'   history-beginning-search-forward

#bindkey "^[[5~" # PageUp
#bindkey "^[[6~" # PageDown
bindkey "^[[3~" delete-char

## Home and End key mapping
# for cygwin
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# for linux
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
# for screen
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

zstyle ":completion:*default"  list-colors ""

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

# path
#export PATH="/cygdrive/c/Program Files/SumatraPDF:$PATH"
#export PATH="/cygdrive/c/texlive/2013/bin/win32:$PATH"
#export PATH="$PATH:/cygdrive/c/usr/local/vim74-kaoriya-win32"

## local path
export PATH="${HOME}/local/bin:$PATH"
export MANPATH="${HOME}/local/man:$MANPATH"
export LD_LIBRARY_PATH="${HOME}/local/lib:$LD_LIBRARY_PATH"

## for python pip local installed package
export PATH=${HOME}/.local/bin:$PATH 
export MANPATH=${HOME}/.local/man:$MANPATH
export LD_LIBRARY_PATH=${HOME}/.local/lib:$LD_LIBRARY_PATH

zstyle ":completion:*:commands" rehash # update PATH when change
unsetopt cdablevars # invalid additional candidacy when cd completation


# リモートから起動するコマンド用の環境変数を設定(必要なら)
export RSYNC_RSH=ssh
export CVS_RSH=ssh

#export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8

export CYGWIN="nodosfilewarning winsymlinks:native"
### binding keys
bindkey -e
#bindkey '^p'   history-beginning-search-backward
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

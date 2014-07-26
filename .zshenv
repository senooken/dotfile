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
# (N-/) を付けることで存在しなければ無視してくれる path=( /usr/*/*bin(N-/) /usr/local/*/*bin(N-/) /var/*/*bin(N-/) /usr/*bin /*bin)

zstyle ":completion:*:commands" rehash 1 # update PATH when change
unsetopt cdablevars # invalid additional candidacy when cd completation
setopt interactivecomments # line end comment out after #
unsetopt equals # invalid = expansion for bash script [ == ].

export WINEARCH=win32

# リモートから起動するコマンド用の環境変数を設定(必要なら)
export RSYNC_RSH=ssh
export CVS_RSH=ssh

#case $TERM in
#    linux) LANG=C ;;
#    *) LANG=ja_JP.UTF-8 ;;
#esac

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
# case insensitive completion
zstyle ':completion:*' matcher-list "m:{a-zA-A}={A-Za-z}"

## for shared shell setting
[ -e ~/.zbashrc ] && source ~/.zbashrc

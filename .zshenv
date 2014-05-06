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

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
path=( /usr/*/*bin(N-/) /usr/local/*/*bin(N-/) /var/*/*bin(N-/) /usr/*bin /*bin)

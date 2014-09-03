#####################################################################
#
#  Sample .zshenv file
#
#  initial setup file for both interactive and noninteractive zsh
#
#####################################################################

# [[ $OSTYPE == cygwin ]] || limit coredumpsize 0
# [[ $OSTYPE == msys ]] || limit coredumpsize 0

# Setup command search path
typeset -U path
# (N-/) を付けることで存在しなければ無視してくれる
# path=( /usr/*/*bin(N-/) /usr/local/*/*bin(N-/) /var/*/*bin(N-/) /usr/*bin /*bin)

## binding keys
bindkey -e

#bindkey '^n'   history-beginning-search-forward

#bindkey "^[[5~" # PageUp
#bindkey "^[[6~" # PageDown
bindkey "^[[3~" delete-char

### Home and End key mapping
# for cygwin
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# for linux
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
# for screen
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

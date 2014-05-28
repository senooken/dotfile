

#####################################################################
#
#  Sample .zshrc file
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

###
# Set Shell variable
# WORDCHARS=$WORDCHARS:s,/,,
HISTSIZE=200 HISTFILE=~/.zhistory SAVEHIST=180

# Set shell options
# 有効にしてあるのは副作用の少ないもの
setopt auto_cd auto_remove_slash auto_name_dirs 
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types no_beep always_last_prompt
setopt sh_word_split auto_param_keys pushd_ignore_dups
# 便利だが副作用の強いものはコメントアウト
#setopt auto_menu  correct rm_star_silent sun_keyboard_hack
#setopt share_history inc_append_history

## For wget proxy
# export http_proxy="http://proxy.kuins.net:8080/"
# export ftp_proxy="http://proxy.kuins.net:8080/"



export LESS=-iMR
#export DISPLAY=localhost:0.0
export DISPLAY=:0.0

# Alias and functions
alias copy='cp -ip' del='rm -i' move='mv -i'
alias fullreset='echo "\ec\ec"'
h ()        {history $* | less}
alias ja='LANG=ja_JP.eucJP XMODIFIERS=@im=kinput2'
#alias ls='ls -aF --color=auto' la='ls -a' ll='ls -lhF --color=auto'
mdcd ()     {mkdir -p "$@" && cd "$*[-1]"}
mdpu ()     {mkdir -p "$@" && pushd "$*[-1]"}
alias pu=pushd po=popd dirs='dirs -v'

# Suffix aliases(起動コマンドは環境によって変更する)
alias -s pdf=acroread dvi=xdvi 
alias -s {odt,ods,odp,doc,xls,ppt}=soffice
alias -s {tgz,lzh,zip,arc}=file-roller

# binding keys
bindkey -e
#bindkey '^p'   history-beginning-search-backward
#bindkey '^n'   history-beginning-search-forward


# 補完システムを利用: 補完の挙動が分かりやすくなる2つの設定のみ記述
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
autoload -U compinit && compinit

## alias
alias ls="ls -AFh --color=auto" ll="ls -lh --color=auto"
alias l="ls -AFh --color=auto"
#alias cp="cp -i" mv="mv -i"

alias df="df -h" du="du -h"
alias ps="ps w"
## for run emacs in terminal
alias emacs="emacs -nw"

## share gnu screen clipboard
if which xsel > /dev/null 2>&1
then
    # X Window System 環境でのコピー （xsel をインストールする必要あり）
    copy_cmd="xsel -i -b < /tmp/screen-exchange;\
              xsel -i -p < /tmp/screen-exchange"
elif which pbcopy > /dev/null 2>&1
then
    # Mac OS X 環境でのコピー （要動作テスト）
    copy_cmd="pbcopy < /tmp/screen-exchange"
elif which putclip > /dev/null 2>&1
then
    # copy on Cygwin
    copy_cmd='iconv -s -t SJIS < /tmp/screen-exchange | putclip'
#    copy_cmd='nkf -s < /tmp/screen-exchange | putclip'
fi
#[ $STY ] && [ $copy_cmd ] &&\
[ $STY ] && [ "$copy_cmd" ] && {
  screen -X bindkey -m ' ' eval "stuff ' '" writebuf "exec sh -c '$copy_cmd'"
  screen -X bindkey -m 'Y' eval "stuff 'Y'" writebuf "exec sh -c '$copy_cmd'"
  screen -X bindkey -m 'W' eval "stuff 'W'" writebuf "exec sh -c '$copy_cmd'"}

## run Gnu screen 
if [ "$WINDOW" = '' ]; then
#   which screen > /dev/null && screen -d -R
fi
#screen -xR

# prompt
# スラッシュ7以上でカレントパスを左側に表示
PROMPT=$'%7(~|[%~]\n|)%{\e[35m%}%n%#%{\e[m%} '
RPROMPT=$'%7(~||[%~])'


## for model setting
if [ -e ~/.modelrc ]; then
    source ~/.modelrc
fi

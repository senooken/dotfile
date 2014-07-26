#####################################################################
#
#  Sample .zshrc file
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

## plugin manage
if [ -f ~/.zsh/antigen/antigen.zsh ]; then
  ADOTDIR=$HOME/.zsh/
  source ~/.zsh/antigen/antigen.zsh
  # antigen use oh-my-zsh

  ## bundles from the default repository (robbyussell's oh-my-zsh)
  # antigen bundle git
  # antigen bundle heroku
  antigen bundle pip
  # # antigen bundle lein
  antigen bundle command-not-found
  #
  antigen-bundle zsh-users/zsh-completions
  antigen-bundle history
  antigen-bundle cp
  antigen-bundle github
  antigen-bundle gnu-utils
  antigen-bundle python
  # antigen-bundle hchbaw/auto-fu.zsh # need unsetopt sh_word_split
  #   zle-line-init () {auto-fu-init;}
  #   zle -N zle-line-init
  #   zstyle ':completion:*' completer _oldlist _complete
  #   zle -N zle-keymap-select auto-fu-zle-keymap-select
  #
  #   # Enterを押したときは自動補完された部分を利用しない。
  #   afu+cancel-and-accept-line() {
  #       ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
  #       zle afu+accept-line
  #   }
  #   zle -N afu+cancel-and-accept-line
  #   bindkey -M afu "^M" afu+cancel-and-accept-line  
  #   zstyle ':auto-fu:var' postdisplay $'' # 「-azfu-」を表示させない
  antigen-bundle zsh-users/zsh-syntax-highlighting 
  # antigen-bundle tarruda/zsh-autosuggestions
  
  # antigen theme robbyrussell
  antigen-apply
fi

###
# Set Shell variable
WORDCHARS=$WORDCHARS:s,/,, # C-wのときに/で区切る
## history
HISTSIZE=9999 HISTFILE=~/.zhistory SAVEHIST=$HISTSIZE
setopt extended_history
setopt hist_ignore_dups
setopt inc_append_history
# setopt hist_ignore_space 

# Set shell options
# 有効にしてあるのは副作用の少ないもの
setopt auto_cd auto_name_dirs 
setopt auto_remove_slash 
setopt extended_glob list_types no_beep always_last_prompt
setopt sh_word_split auto_param_keys pushd_ignore_dups
setopt auto_param_keys pushd_ignore_dups
setopt mark_dirs
REPORTTIME=10
setopt auto_param_slash # auto appen directory var /
setopt rm_star_silent

# 便利だが副作用の強いものはコメントアウト
#setopt auto_menu  correct rm_star_silent sun_keyboard_hack
#setopt share_history inc_append_history

## For wget proxy
# export http_proxy="http://proxy.kuins.net:8080/"
# export ftp_proxy="http://proxy.kuins.net:8080/"

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
autoload -U compinit && compinit -u

### Global aliases 
alias -g A="| awk"
alias -g G="| grep"
alias -g GV="| grep -v"
alias -g H="| head"
alias -g L="| $PAGER"
alias -g R="| ruby -e"
alias -g S="| sed"
alias -g T="| tail"
alias -g V="| vim -R -"
alias -g U=' --help | head'
alias -g P=" --help | $PAGER"
alias -g W="| wc"

### development
alias py='python'
alias rb='ruby'
alias gpp='g++'

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

## prompt
setopt prompt_subst # valid variable expansion 
setopt transient_rprompt # clear rprompt after next line

RED="%{\e[31m%}"
# スラッシュ7以上でカレントパスを左側に表示
PROMPT=$'%7(~|[%~]\n|)%{\e[35m%}%n%#%{\e[m%} '
RPROMPT=$'%7(~||[%{\e[31m%}%~%{\e[m%}])'


# pip zsh completion start
function _pip_completion {
local words cword
read -Ac words
read -cn cword
reply=( $( COMP_WORDS="$words[*]" \
  COMP_CWORD=$(( cword-1 )) \
  PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

## insert last argument by  C-]
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word  # ここはお好みの割り当てにする

## quote previous word in single or double quote by Meta-s, Meta-d
autoload -U modify-current-argument
_quote-previous-word-in-single() {
  modify-current-argument '${(qq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

_quote-previous-word-in-double() {
  modify-current-argument '${(qqq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double


zstyle ':completion:*:default' menu select=2 # select completion



zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

## ignore object file and intermediate file
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

zstyle ':completion:*' use-cache true # speed up apt


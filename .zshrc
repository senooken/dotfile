#####################################################################
#
#  Sample .zshrc file
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

## Plugin manage
export ZPLUG_HOME=~/.zsh/
if [ -f ${ZPLUG_HOME}/zplug/zplug ]; then
  source ${ZPLUG_HOME}/zplug/zplug

  # Make sure you use double quotes
  zplug "zsh-users/zsh-history-substring-search"

  zplug "zsh-users/zaw", of:"*zaw.zsh"
    ## cdr
    autoload -Uz is-at-least
    if is-at-least 4.3.11
    then
      autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
      add-zsh-hook chpwd chpwd_recent_dirs
      zstyle ':chpwd:*' recent-dirs-max 1000
      zstyle ':chpwd:*' recent-dirs-default yes
      zstyle ':completion:*' recent-dirs-insert both
    fi

    zstyle ':filter-select' case-insensitive yes # 絞り込みをcase-insensitive
    # bindkey '^m' zaw
    bindkey "^r" zaw-history
    bindkey "^m^m" zaw-cdr

  zplug load --verbose
fi

###
# Set Shell variable
WORDCHARS=$WORDCHARS:s,/,, # C-wのときに/で区切る
## history
HISTSIZE=100000 HISTFILE=~/.zhistory SAVEHIST=$HISTSIZE
setopt extended_history
setopt hist_ignore_dups # 重複した履歴は無視
setopt inc_append_history
setopt hist_ignore_space
setopt share_history

# Set shell options
# http://voidy21.hatenablog.jp/entry/20090902/1251918174
# 有効にしてあるのは副作用の少ないもの
setopt auto_cd auto_name_dirs
setopt auto_remove_slash
setopt list_types no_beep always_last_prompt
setopt pushd_ignore_dups
# unsetopt sh_word_split  # need zaw, auto-fu
setopt pushd_ignore_dups
# setopt auto_param_slash # auto append directory var /
REPORTTIME=10
setopt rm_star_silent
setopt BSD_ECHO # echo時にエスケープシーケンスを解釈させない(bashと同挙動)

# 便利だが副作用の強いものはコメントアウト
#setopt auto_menu  correct rm_star_silent sun_keyboard_hack
#setopt share_history inc_append_history

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
alias -g A="|& awk"
alias -g G="|& grep"
alias -g GE="| grep -i error"
alias -g GV="| grep -v"
alias -g H="|& head"
alias -g L="|& $PAGER"
alias -g N="2>&1 > /dev/null"
alias -g R="| ruby -e"
alias -g S="|& sed"
alias -g T="|& tail"
alias -g V="| vim -R -"
alias -g U=' --help | head'
alias -g P=" --help | $PAGER"
alias -g W="| wc"

#### Copy to clipboard
[ "`command -v xsel`" ] && alias -g C="| xsel -ib" # Linux
[ "`command -v putclip`" ] && alias -g C="| putclip" # Cygwin
[ "`command -v clip`" ] && alias -g C="| clip" # MSYS (Windows)
[ "`command -v pbcopy`" ] && alias -g C="| pbcopy" # Mac

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

## tmux
PROMPT+='$([ -n "$TMUX" ] && tmux display -p "#I-#P: ")'

## insert last argument by  C-]
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word  # ここはお好みの割り当てにする

## quote previous word in single or double quote by Meta-s, Meta-w
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
bindkey '^[w' _quote-previous-word-in-double


#色の定義
# local DEFAULT=$'%{^[[m%}'$
# local RED=$'%{^[[1;31m%}'$
# local GREEN=$'%{^[[1;32m%}'$
# local YELLOW=$'%{^[[1;33m%}'
# local BLUE=$'%{^[[1;34m%}'$
# local PURPLE=$'%{^[[1;35m%}'$
# local LIGHT_BLUE=$'%{^[[1;36m%}'$
# local WHITE=$'%{^[[1;37m%}'$

zstyle ':completion:*:default' menu select=2 # select completion
zstyle ':completion:*' verbose yes
# zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' completer _complete _match _approximate _list _history _ignored _prefix
## _expandをつけると$HOMEなどが展開されて面倒くさい。

# zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
# zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
# zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
# zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

## ignore object file and intermediate file
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*' use-cache true # speed up apt
zstyle ":completion:*:commands" rehash 1 # update PATH when change
setopt interactivecomments # line end comment out after #
unsetopt equals # invalid = expansion for bash script [ == ].

## setting of completion
unsetopt cdable_vars # invalid additional candidacy when cd completation
# setopt glob_dots # valid completion start from . file
setopt magic_equal_subst # コマンドラインの引数で --prefix=/usrなど=以降でも補完
setopt mark_dirs # append / when expansion file = directory
setopt complete_in_word # 単語の途中でも補完を有効化
setopt extended_glob # ファイル名パターンマッチに使えるフラグを有効化

## pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
    COMP_CWORD=$(( cword-1 )) \
    PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
## pip zsh completion end


# リモートから起動するコマンド用の環境変数を設定(必要なら)
export RSYNC_RSH=ssh
export CVS_RSH=ssh

#case $TERM in
#    linux) LANG=C ;;
#    *) LANG=ja_JP.UTF-8 ;;
#esac

zstyle ":completion:*default"  list-colors ""
# case insensitive completion
zstyle ':completion:*' matcher-list "m:{a-zA-A}={A-Za-z}"

## terminal title
precmd() {eval "${PROMPT_COMMAND}"}

## for shared shell setting
[ -f "$HOME/.zbashrc" ] && . "$HOME/.zbashrc"

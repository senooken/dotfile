# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.1-1

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# User dependent .bashrc file

# If not running interactively, don't do anything
# [[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTSIZE=9999  # number of saved history commands
export HISTFILESIZE=$HISTSIZE # number of saved history command lines
export HISTTIMEFORMAT="%Y%m%dT%H%M "

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
#
# Some shortcuts for different directory listings
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
# 
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
# 
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
# 
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
# 
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
# 
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
# 
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
# 
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
# 
#   return 0
# }
# 
# alias cd=cd_func


# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

export TMPDIR=/tmp
export TZ=JST-09
export MAKE_MODE=unix

JLESSCHARSET=japanese-sjis
export PATH JLESSCHARSET

## prompt
PURPLE="\[\e[35m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
CLEAR="\[\e[m\]"

# 階層 >= 8でプロンプトが2行になる
PS1="\`if [[ \$(expr length \${PWD//[^\/]/}) > 7 ]]; then
  echo '$PURPLE\u:$RED\w$PURPLE\n\$ $CLEAR'
  else echo '$PURPLE\u:$RED\w$PURPLE\$ $CLEAR' ; fi\`"

## shell option
shopt -s autocd
shopt -s cdable_vars # enable cd <var>
shopt -s cdspell # auto modify cd path in missing.
shopt -s extglob # extentive regex. ?，*, +, @, !(1|2)
# shopt -s direxpand # auto modify in completion # old bash not support
# shopt -s dotglob # include .dotfile in <command> *.
shopt -s hostcomplete # try host completion
shopt -s globstar # **: match recursive subdirectory. **/: only 1 recursive.
shopt -s nocaseglob # ignore case

[ ! -n "${TERM}" ] && TERM=cygwin

## synchonization of bash history [130414]
# url: http://iandeth.dyndns.org/mt/ian/archives/000651.html
# function share_history {  # 以下の内容を関数として定義
#   history -a  # .BASH_HISTORYに前回コマンドを1行追記
#   history -c  # 端末ローカルの履歴を一旦消去
#   history -r  # .BASH_HISTORYから履歴を読み込み直す
# }
# PROMPT_COMMAND='share_history'  # 上記関数をプロンプト毎に自動実施
# shopt -u histappend   # .bash_history追記モードは不要なのでOFFに
## for shared shell setting
[ -r ~/.zbashrc ] && source ~/.zbashrc
# source /opt/OpenFOAM/OpenFOAM-2.3.x/etc/bashrc.win


## .bashrc personal setting.

## language (2013/01/27)
#setenv LANG C
#setenv LANG ja_JP.UTF-8
setenv LANG en_US.UTF-8


## synchonization of bash history [130414]
# url: http://iandeth.dyndns.org/mt/ian/archives/000651.html
#function share_history {  # 以下の内容を関数として定義
#	    history -a  # .bash_historyに前回コマンドを1行追記
#	    history -c  # 端末ローカルの履歴を一旦消去
#	    history -r  # .bash_historyから履歴を読み込み直す
#}
#PROMPT_COMMAND='share_history'  # 上記関数をプロンプト毎に自動実施
#shopt -u histappend   # .bash_history追記モードは不要なのでOFFに
setenv HISTSIZE 9999  # 履歴のMAX保存数を指定


### alias
alias ls="ls -aFh --color=auto"

## for run emacs in terminal
alias emacs="emacs -nw"

### VCS (Version Control Sytem)
##  Subversion (2013/01/25)
setenv SVN_EDITOR vim

## Git complementation
#source $HOME/local/git/contrib/completion/git-completion.tcsh

## Gnuplot (2013/02/28)
setenv GNUPLOT_LIB ""		# data or script path

## libevent.pc (tmux) (130413)
#setenv PKG_CONFIG_PATH $HOME/local/lib/pkgconfig

## run Gnu screen 4.1 (130413)
#if [ "$WINDOW" = '' ]; then
#    screen-4.1.0.exe -d -R
##   screen -d -R
#fi

setenv SMK_HOME /home/Senoo/research/SMOKEv3.0 

set autocorrect # 補完前にスペル訂正
set complete = enhance # ignore case
set filec # valid completion csh
## time コマンドの出力書式: この設定で、8秒以上 CPU を使った処理は自動的に time を表示してくれる。
set time=(8 "?
    tIME SPENT IN USER MODE   (cpu SECONDS) : %uS?
    tIME SPENT IN KERNEL MODE (cpu SECONDS) : %sS?
    tOTAL TIME                              : %eS?
    cpu UTILISATION (PERCENTAGE)            : %p?
    tIMES THE PROCESS WAS SWAPPED           : %w?
    tIMES OF MAJOR PAGE FAULTS              : %f?
    tIMES OF MINOR PAGE FAULTS              : %r")

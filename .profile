################################################################################
## \file      .profile
## \author    SENOO, Ken
## \copyright CC0
################################################################################

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

case "$-" in (*i*) set -x;; esac

## Environmental variables
export ENV=${ENV-$HOME/.profile}

export LOCAL=$HOME/.local
export J=$(grep -cs '^processor' /proc/cpuinfo || echo 2)

### Locale
export LANG='ja_JP.UTF-8' LANGUAGE='en'
export LC_MESSAGES='en_US.UTF-8'
## Use ISO 8601 date time format (YYYY-MM-DDThh:mm:ss).
ISO8601_LOCALE=$(command -v locale >/dev/null && locale -a | sort -r |
	grep -e en_CA.UTF-8 -e en_DK -e se_NO -e si_LK -e sv_SE.ISO | head -n 1)
LC_TIME=$ISO8601_LOCALE date +%x | grep -q - && export LC_TIME=$ISO8601_LOCALE

## \brief Export specific GitHub directory.
## \param[in] $1 target directory in GitHub repository URL.
export_github(){
  svn export $(awk -v t=${1+"$@"} 'BEGIN{sub("/(blob|tree)/master/", "/trunk/", t); print t}')
}

is_variable_defined(){ eval \${$1+true} false; }

run_if_exe_enabled(){ is_exe_enabled "$1" && ${1+"$@"}; }

is_exe_enabled(){
	IS_ENABLED_SET_E=$(case "$-" in (*e*) echo true;; (*) echo false;; esac)
	is_command_enabled(){ command -v : >/dev/null 2>&1; }

	## Bourne shell has no `command` command. For Solaris 10, UnixWare 7.1.
	## このBourne shell用のガードははたしているのだろうか？
	$IS_ENABLED_SET_E && set +e
	if is_command_enabled; then
		$IS_ENABLED_SET_E && set -e
		command -v ${1+"$@"} >/dev/null 2>&1 && return || return
	fi
	$IS_ENABLED_SET_E && set -e

	is_exe_existed ${1+"$@"}
}

## \brief Check if exe existed without command/type/which/whence for posh.
is_exe_existed(){
	unset OLD_IFS
	${IFS+true} false && OLD_IFS="$IFS"
	IFS=:

	for path in $PATH; do
		command -p [ -x "$path"/${1+"$@"} ] && break
	done
	FOUND=$?

	${OLD_IFS+true} false && IFS="$OLD_IFS" || unset IFS
	return $FOUND
}

is_opt_enabled()(
	EXE="$1" OPT="$2"
	"$EXE" --help 2>&1 | grep -q -- "$OPT"'[[:blank:],=[]'
)

alias source='.'

IS_INTERACTIVE=$(case "$-" in (*i*) echo true;; (*) echo false;; esac)
IS_INITIALIZED=${IS_INITIALIZED:+true} IS_INITIALIZED=${IS_INITIALIZED:-false}

### Interactive shell local development PATH
if $IS_INTERACTIVE && ! $IS_INITIALIZED; then
	export IS_INITIALIZED='true'
	# set -ux
	export ENV="${ENV:-$HOME/.profile}"
	LOCAL="$HOME/.local"

	## PATH Initialize
	POSIX_PATH=$(command -v getconf >/dev/null && command -p getconf PATH)
	[ -n "$POXIX_PATH" ] && PATH=$POSIX_PATH${PATH+:$PATH}

	## Android
	PATH="/system/bin:/system/xbin${PATH+:$PATH}"
	LD_LIBRARY_PATH="/vendor/lib:/system/lib${LD_LIBRARY_PATH+:$LD_LIBRARY_PATH}"

	for dir in /usr /usr/local /opt "$LOCAL" "$LOCAL/opt"; do
		[ -d "$dir" ] || continue
		for sub in lib lib64 lib32 lib/x86_64-linux-gnu lib/i386-linux-gnu; do
			[ -d "$dir/$sub" ] || continue
			LD_LIBRARY_PATH="$dir/$sub:$LD_LIBRARY_PATH"
			LIBRARY_PATH="$dir/$sub${LIBRARY_PATH+:$LIBRARY_PATH}"
			LD_FLAGS="-L$dir/$sub${LD_FLAGS+ $LD_FLAGS}"
			PKG_CONFIG_PATH="$dir/$sub/pkgconfig${PKG_CONFIG_PATH+:$PKG_CONFIG_PATH}"
		done

		PATH="$dir/bin:$dir/sbin:$PATH"
		CPATH="$dir/include${CPATH+:$CPATH}"

		[ -d "$dir/share" ] || continue
		INFOPATH="$dir/share/info${INFOPATH+:$INFOPATH}"
		MANPATH="$dir/share/man${MANPATH+:$MANPATH}"
		## For Busybox
		MANDATORY_MANPATH="$dir/share/man${MANDATORY_MANPATH+:$MANDATORY_MANPATH}"
		PKG_CONFIG_PATH="$dir/share/pkgconfig${PKG_CONFIG_PATH+:$PKG_CONFIG_PATH}"
		ACLOCAL_PATH="$dir/share/aclocal${ACLOCAL_PATH+:$ACLOCAL_PATH}"
		CLASS_PATH="$dir/share/java${CLASS_PATH+:$CLASS_PATH}"

		## For ncurses
		[ -d "$dir/share/terminfo" ] && export TERMINFO="$dir/share/terminfo"
	done

	## Apache HTTP Server (httpd)
	export APACHE_HOME="$LOCAL/apache2"
	if [ -d "$APACHE_HOME" ]; then
		PATH="$APACHE_HOME/bin:$PATH"
		CPATH="$APACHE_HOME/include:$CPATH"
		MANPATH="$APACHE_HOME/man:$MANPATH"
		MANDATORY_MANPATH="$MANPATH"
	fi

	## MySQL
	export MYSQL_HOME="$LOCAL/mysql"
	if [ -d "$MYSQL_HOME" ]; then
		PATH="$MYSQL_HOME/bin:$PATH"
		CPATH="$MYSQL_HOME/include:$CPATH"
		LD_LIBRARY_PATH="$MYSQL_HOME/lib:$LD_LIBRARY_PATH"
		LIBRARY_PATH="$LD_LIBRARY_PATH"
		MANPATH="$MYSQL_HOME/man:$MANPATH"
		MANDATORY_MANPATH="$MANPATH"
		PKG_CONFIG_PATH="$MYSQL_HOME/lib/pkgconfig:$MYSQL_HOME/share/pkgconfig:$PKG_CONFIG_PATH"
		ACLOCAL_PATH="$MYSQL_HOME/share/aclocal:$ACLOCAL_PATH"
	fi

	## PostgreSQL
	[ -d "${PGDATA:=$LOCAL/var/lib/pgsql/data}" ] && export PGDATA

	## Qt
	# export QT_HOME="$LOCAL/qt5"
	if [ -d "$QT_HOME" ]; then
		PATH="$QT_HOME/bin:$PATH"
		CPATH="$QT_HOME/include:$CPATH"
		LD_LIBRARY_PATH="$QT_HOME/lib:$LD_LIBRARY_PATH"
		LIBRARY_PATH="$LD_LIBRARY_PATH"
		PKG_CONFIG_PATH="$QT_HOME/lib/pkgconfig:$PKG_CONFIG_PATH"
	fi

	export PATH LD_LIBRARY_PATH LIBRARY_PATH CPATH PKG_CONFIG_PATH LDFLAGS
	export MANPATH MANDATORY_MANPATH INFOPATH CLASS_PATH ACLOCAL_PATH

	## Language specific configuration
	# export GEM_HOME="$LOCAL"       # ruby gem
	# export PYTHONUSERBASE="$LOCAL" # python pip
	PYTHONVERSION=$(run_if_exe_enabled python3 -V | grep -o '[0-9]\.[0-9]*')
	### Perl
	export PERL5LIB="$LOCAL/lib/perl5${PERL5LIB+:$PERL5LIB}"
	export PERL_LOCAL_LIB_ROOT="$LOCAL${PERL_LOCAL_LIB_ROOT+:$PERL_LOCAL_LIB_ROOT}"
	export PERL_MB_OPT=" --install_base $LOCAL"
	export PERL_MB_OPT=" --install_path bindoc=$LOCAL/share/man/man1 $PERL_MB_OPT"
	export PERL_MB_OPT=" --install_path libdoc=$LOCAL/share/man/man3 $PERL_MB_OPT"
	export PERL_MM_OPT=" INSTALL_BASE=$LOCAL"
	export PERL_MM_OPT=" INSTALLSITEMAN1DIR=$LOCAL/share/man/man1 $PERL_MM_OPT"
	export PERL_MM_OPT=" INSTALLSITEMAN3DIR=$LOCAL/share/man/man3 $PERL_MM_OPT"

	### PHP
	export PHP_INI_SCAN_DIR="$LOCAL/etc:"
	export PHP_PEAR_PHP_BIN='php' PHP_PEAR_INSTALL_DIR="$LOCAL/lib/php"
	export PATH="${XDG_CONFIG_HOME:-$HOME/.config}/composer/vendor/bin:$PATH"
	## Invalid stty keybind
	# stty start undef
	export DISPLAY="${DISPLAY:-:0}"

	## Utility
	NULL='/dev/null'
	POSIX_PATH=$(command -p getconf PATH 2>&- || env -i command -p sh -c 'echo "$PATH"')
	HT=$(printf '\t')
	LF=$(printf '\n.') LF="${LF%.}"
	DIGIT='0 1 2 3 4 5 6 7 8 9'
	ALPHA_U='A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'
	ALPHA_L='a b c d e f g h i j k l m n o p q r s t u v w x y z'
	SHS='sh ksh ksh93 pdksh oksh lksh mksh posh ash dash bash zsh yash'
	CV='eval command -v'
	BOM8=$(printf '\357\273\277')
	BOM16LE=$(printf '\377\376')
	BOM16BE=$(printf '\376\377')

	HOME=${HOME:-~}      # for MSYS
fi

### Windows shell
export CYGWIN='nodosfilewarning winsymlinks:nativestrict'
export MSYS='winsymlinks:nativestrict'

### For wine
export WINEARCH='win32' WINEPREFIX="$HOME/.wine32"

### For unzip encoding
if grep -sq 'debian' /etc/os-release; then
	export UNZIP='-O cp932'
	export ZIPINFO='-O cp932'
fi

: ${LOGNAME:=$(id -nu)}  # for Windows shell
: ${COLUMNS:=80}          # for sh

## Prompt
if [ -n "$BASH" ]; then
	ENCLOSE_OPEN='\\\['
	ENCLOSE_CLOSE='\\\]'
elif [ -n "$ZSH_NAME" ]; then
	ENCLOSE_OPEN='%%{'
	ENCLOSE_CLOSE='%%}'
fi

BLUE='\033[34m'
PURPLE='\033[35m'
RED='\033[31m'
CLEAR='\033[m'

for color in PURPLE BLUE RED CLEAR; do
	eval "$color=$ENCLOSE_OPEN\$$color$ENCLOSE_CLOSE"
done

CWD='$(pwd | sed s@$HOME@~@)'
USERNAME=$(id -nu)
HOST=$(uname -n)
[ $(id -u) = 0 ] && PROMPT_SIGN='#' || PROMPT_SIGN='$'
PROMPT_NAME="$PURPLE$USERNAME@$HOST:$RED"
PROMPT_MARK="$PURPLE$PROMPT_SIGN $CLEAR"

	# PROMPT_LINE=\"\$?$PROMPT_NAME$CWD\"
PS1="\$(
	PROMPT_LINE=\"\$(printf '%03d' \$?)$PROMPT_NAME$CWD\"
	GIT_PS1= PROMPT_INFO=$USERNAME@$HOST:$CWD$
	command -v __git_ps1 >/dev/null && [ "$BASH$ZSH_NAME" ] &&
		GIT_PS1=\$(__git_ps1 ':%s')
	[ \$((COLUMNS-\${#PROMPT_INFO}-\${#GIT_PS1})) -le 20 ] &&
		PROMPT_LINE=\"\$PROMPT_LINE\n\"
	printf '%s' \"\$PROMPT_LINE$BLUE\$GIT_PS1$PROMPT_MARK\"
)"

### git-prompt.sh
case "$BASH$ZSH_NAME" in *)
	export GIT_PS1_SHOWDIRTYSTATE=true
	export GIT_PS1_SHOWSTASHSTATE=true
	export GIT_PS1_SHOWUNTRACKEDFILES=true
	export GIT_PS1_SHOWUPSTREAM="verbose"
esac

## Terminal title
case "$TERM" in ?term*|rxvt*|screen*)
	COMMON_PROMPT_EXE='printf %b "\033]0;$0@$HOST: $(pwd | sed s@$HOME@~@)\007"'
esac

## For 256 color terminal.
case "$TERM" in *-256color*);; *)
	COLOR_TERM=$(env -i sh -c 'command -v toe >/dev/null && toe -a' | awk '/-256color/ {print $1; exit}')
	export TERM="${COLOR_TERM:-$TERM}"
esac

## Alias
### Enable alias in non-interactive shell
[ -n "${BASH-}"     ] && shopt -s expand_aliases
[ -n "${ZSH_NAME-}" ] && setopt aliases

### Windows character encoding convert
if [ "${OS-}" = "Windows_NT" ]; then
	wincmd(){
		EXE="$1"
		shift
		"$EXE" ${1+"$@"} 2>&1 | iconv -f CP932 -t UTF-8
	}

	for exe in javac ant ping ipconfig netstat netsh taskkill reg; do
		eval "alias $exe='wincmd $exe'"
	done

	alias cs='wincmd cscript.exe /NoLogo'
	alias ws='wincmd wscript.exe /NoLogo'
	alias choco='wincmd choco'
else
	alias cs='wine cscript.exe /NoLogo'
	alias ws='wine wscript.exe /NoLogo'
fi

### ls
LL_OPTION='-l'
is_opt_enabled ls -G           && LL_OPTION="-G $LL_OPTION"
is_opt_enabled ls --time-style &&
	LL_OPTION="--time-style='+%Y-%m-%d %H:%M' $LL_OPTION"

alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -AFh'
is_opt_enabled ls --color && alias ls='ls -AFh --color=auto'
alias l='ls'
alias ll="ls $LL_OPTION"

### ls color
if is_exe_enabled dircolors; then
	[ -r "${d:=$HOME/.dir_colors}" ] && eval $(dircolors $d) || eval $(dircolors)
fi

### Default to human readable figures
alias df='df -h' du='du -h'
alias ps='ps w'

### Git
alias gic='git commit -am'
alias gia='git add'
alias gim='git mv'
alias gis='git status'
alias glone='git clone'

### Pager
is_exe_enabled less && alias more='less'
export PAGER='less'

export LV='-c -l'
export LESS='-imR'
# alias info='info --vi-keys'

### Open
alias o='open'
case "$OSTYPE" in
	freebsd*|darwin*) alias o='open' ;;
	linux*)           alias open='xdg-open' ;; # alias open="gnome-open";;
	cygwin*)          alias open='cygstart' ;;
	msys*)            alias open='start';;
esac

#### Copy to clipboard
if   is_exe_enabled clip   ; then  # MSYS (Windows)
	alias clip='iconv -sf UTF-8 -t CP932 | clip'
elif is_exe_enabled xsel   ; then  # Linux
	alias clip='xsel -ib'
elif is_exe_enabled xclip  ; then  # Linux
	alias clip='xclip -i'
elif is_exe_enabled putclip; then  # Cygwin
	alias clip='putclip'
elif is_exe_enabled pbcopy ; then  # Mac
	alias clip='pbcopy'
fi

### Development
alias py3='python3' ipy3='ipython3' py2='python2' ipy2='ipython2'
alias py='python'   ipy='ipython'
alias rb='ruby'
alias gp='g++ -Wall -Wextra -pedantic -std=c++1y'
alias gc='gcc -Wall -Wextra -pedantic -std=gnu11'
alias gf='gfortran -Wall -O3 -static'

## stow conflict list
# --ignore="dir|gschemas.compiled|icon-theme-cache"
alias stow='stow --ignore="dir|gschemas.compiled|icon-theme.cache"'

is_exe_enabled vim && alias vi='vim' vim='vim -X'

export EDITOR='vi'
# export SVN_EDITOR=$EDITOR

get_tz()(
	set $(date -u '+%j %H %M'); U_D=${1#0}; U_D=${U_D#0}; U_H=${2#0}; U_M=${3#0}
	set $(date    '+%j %H %M'); L_D=${1#0}; L_D=${L_D#0}; L_H=${2#0}; L_M=${3#0}

	# Fix if year is crossed
	IS_CROSSED_YEAR="[ $L_D = 1 -o $U_D = 1 ] && [ $((L_D+U_D)) -gt 3 ]"
	eval "$IS_CROSSED_YEAR" && U_D=$((L_D == 1 ? L_D-1 : L_D+1))

	dm=$(( (L_D*24*60 + L_H*60 + L_M) - (U_D*24*60 + U_H*60 + U_M) ))
	DIGIT_1=$((dm<0 ? -dm%10 : dm%10))

	# Fix if minute is changed during running date command
	[ $DIGIT_1 = 1 -o $DIGIT_1 = 6 ] && dm=$((dm<0 ? dm+1 : dm-1))
	[ $DIGIT_1 = 4 -o $DIGIT_1 = 9 ] && dm=$((dm<0 ? dm-1 : dm+1))

	printf '%+03d:%+03d\n' $((dm / 60)) $((dm % 60)) | sed 's/:[+-]/:/'
)

now()(
	EXE_NAME='now'
	dt=$(date +%Y%m%dT%H%M%S)
	OPTSTR=':lst-:'
	for opt in $(echo $OPTSTR | sed 's/[:-]//g' | fold -w 1); do
		eval is_opt_$opt='false'
	done

	while getopts $OPTSTR opt; do
		case "$opt${OPTARG-}" in
			l|-long)  dt=$(date +%Y-%m-%dT%H:%M:%S);;
			s|-short) dt=$(date +%Y%m%dT%H%M%S    );;
			t|-time-zone) is_opt_t='true';;
			\?*) echo "$EXE_NAME: invalid option -- '$OPTARG'" >&2;        exit 1;;
			*)   echo "$EXE_NAME: unrecognized option '-$opt$OPTARG'" >&2; exit 1;;
		esac
	done

	if $is_opt_t; then
		TIME_ZONE=$(get_tz)
		[ -n "${dt%%*:*}" ] && TIME_ZONE=$(printf '%s\n' "$TIME_ZONE" | sed 's/://')
		dt="$dt$TIME_ZONE"
	fi

	echo "$dt"
)


# zshでは{=var}というようにして空白区切りで展開して使う。じゃないと使えない
# WXCONFIG=$(wx-config --cppflags --libs 2>&- | tr \"\n\" ' ')
WXCONFIG=$(run_if_exe_enabled wx-config --libs --cppflags)
# GTKCONFIG=$(run_if_exe_enabled pkg-config --exists gtk+-3.0 && pkg-config --libs --cflags gtk+-3.0)
LIBCPP='-static-libgcc -static-libstdc++'

# : ${SCREEN_SHELL:=$(command -v zsh )}
: ${SCREEN_SHELL:=$(command -v bash)}

alias screen="screen -s $SCREEN_SHELL"
alias tmux="SHELL=$SCREEN_SHELL tmux"

## For --exclude list
EXCLUDE_FILE='{cscope.files,cscope.out,cscope.in.out,cscope.po.out,tags,GTAGS,GRTAGS,GPATH}'
EXCLUDE_DIR='{.,..,node_modules,.git,.svn,obj}'

## In GNU grep 2.21+, GREP_OPTIONS environmental variable was deprecated.
is_opt_enabled grep --color  && GREP_OPTIONS='--color=auto'
is_opt_enabled grep -I       && GREP_OPTIONS="$GREP_OPTIONS -I"
is_opt_enabled grep --exclude && GREP_OPTIONS="$GREP_OPTIONS --exclude=$EXCLUDE_FILE"

if is_opt_enabled grep --exclude-dir; then  # v2.5.2 or later
	GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$EXCLUDE_DIR"
elif is_opt_enabled grep --exclude; then
# --exclude=*dir* option is only available when --exclude-dir disabled
	GREP_OPTIONS="$GREP_OPTIONS --exclude={..*,*.git*,*.svn*}"
fi

## Overwrite GNU Readline Tab (complete) by menu-complete
# is_bash_ver_ge_43(){ bash --version | grep -q -e ' 4\.[3-9]*' -e ' [5-9]\.'; }
# if $IS_INTERACTIVE && [ "${0##*/}" = 'bash' ] && is_bash_ver_ge_43; then
# 	bind 'TAB: menu-complete'
# fi

alias grep="grep $GREP_OPTIONS"
# alias ag="ag -fU --ignore=$EXCLUDE_FILE"
alias ag="ag -fU"
alias ctags="ctags --exclude=$EXCLUDE_DIR"

set +x

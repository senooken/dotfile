################################################################################
## \file      .profile
## \author    SENOO, Ken
## \copyright CC0
################################################################################

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

set -x

## Environmental variables
export ENV="${ENV-$HOME/.profile}"

export LOCAL="$HOME/.local"
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
	IS_INITIALIZED='true'
	# set -ux
	export ENV="${ENV:-$HOME/.profile}"
	LOCAL="$HOME/.local"
	### System path
	PATH="/system/bin:/system/xbin${PATH+:$PATH}"
	PATH="/opt/bin:/opt/sbin:$PATH"
	PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"
	PATH="$(command -p getconf PATH 2>&- || :):$PATH"
	PATH="$LOCAL/opt/bin:$LOCAL/opt/sbin:${PATH#:}"
	PATH="$LOCAL/bin:$LOCAL/sbin:$PATH"

	LD_LIBRARY_PATH="/vendor/lib:/system/lib:$LD_LIBRARY_PATH"
	LD_LIBRARY_PATH="/opt/lib64:/opt/lib:$LD_LIBRARY_PATH"
	LD_LIBRARY_PATH="/usr/lib64:/usr/lib:/lib64:/lib:$LD_LIBRARY_PATH"
	LD_LIBRARY_PATH="/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH"
	LD_LIBRARY_PATH="$LOCAL/lib64:$LOCAL/lib:$LOCAL/opt/lib64:$LOCAL/opt/lib:$LD_LIBRARY_PATH"
	LIBRARY_PATH="$LD_LIBRARY_PATH"
	LDFLAGS="-L$LOCAL/lib64 -L$LOCAL/lib -L$LOCAL/opt/lib64 -L$LOCAL/opt/lib"

	CLASSPATH="$LOCAL/share/java:${CLASSPATH:-.}"
	CPATH="/usr/local/include:/usr/include:/opt/include:$CPATH"
	CPATH="$LOCAL/include:$LOCAL/opt/include:$CPATH"

	MANPATH="/usr/local/share/man:/usr/share/man:/opt/man:$MANPATH"
	MANPATH="$LOCAL/share/man:$LOCAL/opt/man:$LOCAL/usr/share/man:$MANPATH"
	MANDATORY_MANPATH="$MANPATH"  # for Busybox
	INFOPATH="/usr/local/share/info:/usr/share/info:$INFOPATH"
	INFOPATH="$LOCAL/share/info:$LOCAL/opt/info:/opt/info:$INFOPATH"

	PKG_CONFIG_PATH="/usr/share/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="/usr/lib64/pkgconfig:/usr/lib/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="/usr/local/share/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="/usr/local/lib64/pkgconfig:/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="/opt/share/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="/opt/lib64/pkgconfig:/opt/lib/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="$LOCAL/opt/share/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="$LOCAL/opt/lib64/pkgconfig:$LOCAL/opt/lib/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="$LOCAL/share/pkgconfig:$PKG_CONFIG_PATH"
	PKG_CONFIG_PATH="$LOCAL/lib64/pkgconfig:$LOCAL/lib/pkgconfig:$PKG_CONFIG_PATH"

	ACLOCAL_PATH="$LOCAL/share/aclocal"

	## Apache
	APACHE_HOME="$LOCAL/apache2"
	if [ -d "$APACHE_HOME" ]; then
		PATH="$APACHE_HOME/bin:$PATH"
		CPATH="$APACHE_HOME/include:$CPATH"
		MANPATH="$APACHE_HOME/man:$MANPATH"
		MANDATORY_MANPATH="$MANPATH"
		export APACHE_HOME
	fi

	## MySQL
	MYSQL_HOME="$LOCAL/mysql"
	if [ -d "$MYSQL_HOME" ]; then
		PATH="$MYSQL_HOME/bin:$PATH"
		CPATH="$MYSQL_HOME/include:$CPATH"
		LD_LIBRARY_PATH="$MYSQL_HOME/lib:$LD_LIBRARY_PATH"
		LIBRARY_PATH="$LD_LIBRARY_PATH"
		MANPATH="$MYSQL_HOME/man:$MANPATH"
		MANDATORY_MANPATH="$MANPATH"
		export MYSQL_HOME
	fi

	## PostgreSQL
	if ${PGDATA:-true} false && [ -d "$LOCAL/var/lib/pgsql/data" ]; then
		export PGDATA="$LOCAL/var/lib/pgsql/data"
	fi

	## Qt
	QT_HOME="$LOCAL/opt/Qt/5.11.1/gcc_64"
	if [ -d "$QT_HOME" ]; then
		PATH="$QT_HOME/bin:$PATH"
		CPATH="$QT_HOME/include:$QT_HOME/include/QtWidgets:$CPATH"
		CPATH="$QT_HOME/include/QtQml:$CPATH"
		LD_LIBRARY_PATH="$QT_HOME/lib:$LD_LIBRARY_PATH"
		LIBRARY_PATH="$LD_LIBRARY_PATH"
		MANPATH="$QT_HOME/man:$MANPATH"
		MANDATORY_MANPATH="$MANDATORY_MANPATH"
		export QT_HOME
	fi

	export PATH LD_LIBRARY_PATH LIBRARY_PATH CPATH PKG_CONFIG_PATH LDFLAGS
	export MANPATH MANDATORY_MANPATH INFOPATH CLASSPATH ACLOCAL_PATH

	## Language specific configuration
	# export GEM_HOME="$LOCAL"       # ruby gem
	# export PYTHONUSERBASE="$LOCAL" # python pip
	PYTHONVERSION=$(run_if_exe_enabled python3 -V | grep -o '[0-9]\.[0-9]*')

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

	## Environmental variables
	: ${HOME:=~}      # for MSYS
	export TMPDIR='/tmp'
	export TZ='JST-9'
fi

### Windows shell
export CYGWIN='nodosfilewarning winsymlinks:nativestrict'
export MSYS='winsymlinks:nativestrict'

### For wine
export WINEARCH='win32'
export WINEPREFIX="$HOME/.wine32"

### For unzip encoding
if grep -sq 'debian' /etc/os-release; then
	export UNZIP='-O cp932'
	export ZIPINFO='-O cp932'
fi

: ${LOGNAME:=$(id -nu)}  # for Windows shell
: ${COLUMNS:=80}          # for sh

## Prompt
PURPLE='\033[35m'
RED='\033[31m'
CLEAR='\033[m'

if [ -n "$BASH" ]; then
	ENCLOSE_OPEN='\\\['
	ENCLOSE_CLOSE='\\\]'
elif [ -n "$ZSH_NAME" ]; then
	ENCLOSE_OPEN='%%{'
	ENCLOSE_CLOSE='%%}'
fi

for color in PURPLE RED CLEAR; do
	eval "$color=$ENCLOSE_OPEN\$$color$ENCLOSE_CLOSE"
done

CWD='$(pwd | sed s@$HOME@~@)'
USERNAME=$(id -nu)
HOST=$(uname -n)
[ $(id -u) = 0 ] && PROMPT_SIGN='#' || PROMPT_SIGN='$'
PROMPT_NAME="$PURPLE$USERNAME@$HOST:$RED"
PROMPT_MARK="$PURPLE$PROMPT_SIGN $CLEAR"

PS1="\$([ \$((COLUMNS - \$(expr \"$USERNAME@$HOST:$CWD$\" : '.*'))) -le 20 ] &&
	printf '$PROMPT_NAME%s\n$PROMPT_MARK' \"$CWD\" ||
	printf '$PROMPT_NAME%s''$PROMPT_MARK' \"$CWD\")"

## Terminal title
case "$TERM" in ?term*|rxvt*|screen*)
	COMMON_PROMPT_EXE='printf %b "\033]0;$0@$HOST: $(pwd | sed s@$HOME@~@)\007"'
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
alias info='info --vi-keys'

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

is_exe_enabled xstow && alias stow='xstow'

## stow conflict list
# --ignore="dir|gschemas.compiled|icon-theme-cache"
# alias stow="stow --ignore='dir|gschemas.compiled|icon-theme.cache'"

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
WXCONFIG=$(run_if_exe_enabled wx-config  --libs --cppflags)
# GTKCONFIG=$(run_if_exe_enabled pkg-config --exists gtk+-3.0 && pkg-config --libs --cflags gtk+-3.0)
LIBCPP='-static-libgcc -static-libstdc++'

: ${SCREEN_SHELL:=$(command -v zsh )}
: ${SCREEN_SHELL:=$(command -v bash)}

## For 256 color terminal.
SCREEN_TERM=$(run_if_exe_enabled toe -a | sort | awk '/-256color/ {print $1; exit}')
: ${SCREEN_TERM:=$TERM}
alias screen="screen -T $SCREEN_TERM -s $SCREEN_SHELL"
alias tmux="SHELL=$SCREEN_SHELL tmux"

## For --exclude list
EXCLUDE_FILE='{cscope.files,cscope.out,cscope.in.out,cscope.po.out,tags,GTAGS,GRTAGS,GPATH}'
EXCLUDE_DIR='{.,..,node_modules,.git,.svn,obj}'

## In GNU grep 2.21 or later, deprecated GREP_OPTIONS environmental variable
is_opt_enabled grep --color  && GREP_OPTIONS='--color=auto'
is_opt_enabled grep -I       && GREP_OPTIONS="$GREP_OPTIONS --color=auto"
is_opt_enabled grep --exlude && GREP_OPTIONS="$GREP_OPTIONS --exclude=$EXCLUDE_FILE"

if is_opt_enabled grep --exclude-dir; then  # v2.5.2 or later
	GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$EXCLUDE_DIR"
elif is_opt_enabled grep --exlude; then
# --exclude=*dir* option is only available when --exclude-dir disabled
	GREP_OPTIONS="$GREP_OPTIONS --exclude={..*,*.git*,*.svn*}"
fi

## Overwrite GNU Readline Tab (complete) by menu-complete
is_bash_ver_ge_43(){ bash --version | grep -q -e ' 4\.[3-9]*' -e ' [5-9]\.'; }
if $IS_INTERACTIVE && [ "${0##*/}" = 'bash' ] && is_bash_ver_ge_43; then
	bind 'TAB: menu-complete'
fi

alias grep="grep $GREP_OPTIONS"
# alias ag="ag -fU --ignore=$EXCLUDE_FILE"
alias ag="ag -fU"
alias ctags="ctags --exclude=$EXCLUDE_DIR"


acinstall()(
	PKG="$1"
	PREFIX="${2-$LOCAL/stow}"
	tar -xf "$PKG."*
	cd "$PKG"
	./configure --prefix="$PREFIX/$PKG" && make && make install &&
		run_if_exe_enabled stow -d "$PREFIX" "$PKG"
)

set +x

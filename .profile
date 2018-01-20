################################################################################
## \file      .profile
## \author    DODESI, HUUKA
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


## Environmental variables
export ENV="${ENV-$HOME/.shrc}"
# [ -r "$ENV" ] && . "$ENV"

LOCAL="$HOME/.local"
CLASSPATH="$LOCAL/share/java:${CLASSPATH:-.}"
PATH="$LOCAL/bin:$PATH"

export LOCAL CLASSPATH PATH

## \brief Export specific GitHub directory.
## \param[in] $1 target directory in GitHub repository URL.
export_github(){
  svn export $(awk -v t="$1" 'BEGIN{sub("/(blob|tree)/master/", "/trunk/", t); print t}')
}

is_variable_defined(){
	eval \${$1+true} false
}

run_if_exe_enabled(){
	is_exe_enabled "$1" && ${1+"$@"}
}

is_exe_enabled(){
	IS_ENABLED_SET_E=$(case "$-" in (*e*) echo true;; (*) echo false;; esac)
	is_command_enabled(){command -v : >/dev/null 2>&1;}

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

## \brief Check exe existed without command/type/which/whence for posh.
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


# if running bash, include .bashrc if it exists
[ -n "$BASH" ] && [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"

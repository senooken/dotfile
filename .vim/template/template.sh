################################################################################
## \file      template.sh
## \author    SENOO, Ken
## \copyright CC0
## \date      first created date: <+DATE+>
## \date      last  updated date: 
################################################################################

## \brief Initialize POSIX shell environment
init(){
	set -eu
	umask 0022
	PATH="$(command -p getconf PATH 2>&-):/bin:/usr/bin${PATH:+:}$PATH"
	export PATH="${PATH#:}" LC_ALL='C'
}

is_main()(
	EXE_NAME='.sh'
	NOW_EXE=$(ps -p $$ -o args=)
	case "$NOW_EXE" in *$EXE_NAME*);; *)
		return 1
	esac
)

init
<+CURSOR+>

:
################################################################################
## \file      template.sh
## \author    SENOO, Ken
## \copyright CC0
## \date      created date: 
## \date      updated date: 
################################################################################

## \brief Initialize POSIX shell environment
init(){
	PATH="$(command -p getconf PATH 2>&-)${PATH+:$PATH}"
	export PATH="${PATH#:}" LC_ALL='C'
	umask 0022
	set -eu
}

is_main()(
	EXE_NAME='.sh'
	[ "$EXE_NAME" = "${0##*/}" ]
)

init

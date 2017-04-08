: POSIX compatible shell script
################################################################################
## \file      template.sh
## \author    SENOO, Ken
## \copyright CC0
## \date      first created date: 
## \date      last  updated date: 
################################################################################

## \brief Initialize POSIX shell environment
init(){
	POSIX_PATH=`command -p getconf PATH 2>&-`
	case "$PATH" in "$POSIX_PATH"*);; *)
		PATH="${POSIX_PATH:+$POSIX_PATH:}$PATH" export PATH
		exec sh "$0" "$@"
	esac

	set -eu
	umask 0022
	export LC_ALL='C'
}

is_main()(
	EXE_NAME='.sh'
	[ "$EXE_NAME" = "${0##*/}" ]
)

init

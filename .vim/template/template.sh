:
################################################################################
## \file      template.sh
## \author    SENOO, Ken
## \copyright CC0
## \version   0.0.0
## \date      Created: 
## \date      Updated: 
################################################################################

## \brief Initialize POSIX shell environment
init(){
	PATH="$(command -p getconf PATH 2>&-):${PATH:-.}"
	export PATH="${PATH#:}" LC_ALL='C'
	umask 0022
	set -eu
}

is_main()(
	EXE_NAME='.sh'
	[ "$EXE_NAME" = "${0##*/}" ]
)

init

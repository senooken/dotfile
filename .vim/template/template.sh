:
################################################################################
## \file      template.sh
## \author    SENOO, Ken
## \copyright CC0
## \version   0.0.0
## \date      Created: 
## \date      Updated: 
################################################################################

EXE_NAME='template'

template() {
	
}

main() {
	## \brief Initialize POSIX shell environment
	init() {
		PATH="$(command -p getconf PATH 2>&-):${PATH:-.}"
		export PATH="${PATH#:}" LC_ALL='C'
		umask 0022
		set -eu
	}

	is_main() { [ "$EXE_NAME.sh" = "${0##*/}" ]; }
	if is_main; then
		init
		$EXE_NAME ${1+"$@"}
	fi
}

main ${1+"$@"}

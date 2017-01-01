#!/bin/sh
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
	export LC_ALL='C' PATH="$(command -p getconf PATH):$PATH"
}

is_main()(
	EXE_NAME='.sh'
	CURRENT_EXE="$(ps -p $$ -o comm=)"
	[ "$EXE_NAME" = "$CURRENT_EXE" ]
)

init
<+CURSOR+>

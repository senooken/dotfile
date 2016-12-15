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
	umask 0022
	set -eu
	unset IFS
	LC_ALL='C'
	PATH="$(command -p getconf PATH):$PATH"
}

init
<+CURSOR+>

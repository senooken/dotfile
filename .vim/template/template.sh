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
	export LC_ALL='C'
	export PATH="$(command -p getconf PATH):${PATH:-}"
}

init
<+CURSOR+>

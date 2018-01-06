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


## Environmental variables
export ENV="${ENV-$HOME/.shrc}"
# [ -r "$ENV" ] && . "$ENV"

LOCAL="$HOME/.local"
CLASSPATH="$LOCAL/share/java:${CLASSPATH:-.}"
PATH="$LOCAL/bin:$PATH"

export LOCAL CLASSPATH PATH

# if running bash, include .bashrc if it exists
[ -n "$BASH" ] && [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"

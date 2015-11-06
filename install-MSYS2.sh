#!/bin/bash
# \file install-MSYS2.sh
# \author SENOO, Ken
# \copyright CC0

PKG="
zsh
"
pacman --noconfirm --needed -Sy bash pacman pacman-mirrors msys2-runtime
pacman --noconfirm -Su
pacman --noconfirm -S $PKG

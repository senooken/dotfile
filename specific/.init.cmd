::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: \file      .init.cmd
:: \author    SENOO, Ken
:: \copyright CC0
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off

doskey ag=ag -U $*
doskey findstr=findstr /p $*

if defined CMD_INIT_SCRIPT_LOADED goto :eof
set CMD_INIT_SCRIPT_LOADED=1

cls

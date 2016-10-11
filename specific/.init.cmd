:: \file      .init.cmd
:: \author    SENOO, Ken
:: \copyright CC0

@echo off

:: doskey
doskey ag=ag -U
doskey findstr=findstr /p

if "%CMD_INIT_SCRIPT_LOADED%" neq "" goto :eof
set CMD_INIT_SCRIPT_LOADED=1

cls

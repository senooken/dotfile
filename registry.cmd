:: \file      registry.cmd
:: \author    SENOO, Ken
:: \copyright CC0

:: Enable executing command on network directory
reg add "HKCU\Software\Microsoft\Command Processor" /v DisableUNCCheck /t REG_DWORD /d 1

:: Set default cmd.exe configuration file
reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d ^%USERPROFILE^%\.init.cmd

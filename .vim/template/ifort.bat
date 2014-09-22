: (File name: )
: (Author: SENOO, Ken)
: (Last update: )

@echo off
call "C:\Program Files (x86)\Intel\Compiler\11.1\054\bin\ia32\ifortvars_ia32.bat"
ifort.exe /nologo *.f*
del *.obj *.mod

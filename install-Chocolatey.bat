:: \file install-Chocolatey.bat
:: \author SENOO, Ken
:: \copyright CC0

:: TODO: ここをちゃんと動作するようにする。

PKG="
keepass
fastcopy
chromium
thunderbird
libreoffice
foxitreader
GoogleJapaneseInput
LinkShellExtension
winmerge-jp
qttabbar
FoxitReader
"

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
choco install -y %PKG%

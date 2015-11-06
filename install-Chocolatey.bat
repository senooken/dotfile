:: \file install-Chocolatey.bat
:: \author SENOO, Ken
:: \copyright CC0

PKG="
chromium
thunderbird
libreoffice
adobereader
foxitreader
GoogleJapaneseInput
LinkShellExtension
winmerge-jp
qttabbar
"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
choco install -y %PKG%

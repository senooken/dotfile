:: \file install-Chocolatey.bat
:: \author SENOO, Ken
:: \copyright CC0

PKG=^
 keepass^
 chromium^
 thunderbird^
 GoogleJapaneseInput^
 LinkShellExtension^
 qttabbar^
 FoxitReader^

@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
choco install -y %PKG%

PKG=^
 fastcopy^
 LibreCAD^
 BlueGriffon^
 VLC^
 libreoffice^

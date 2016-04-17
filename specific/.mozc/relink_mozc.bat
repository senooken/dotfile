REM \file      relink_mozc.bat
REM \author    SENOO, Ken
REM \copyright CC0
REM \date      first created date: 2016-04-17T12:58+09:00
REM \date      last  updated date: 2016-04-17T14:46+09:00
REM \brief     WindowsのGoogle日本語入力のIME設定を更新後、共有ディレクトリに更新された設定ファイルをコピーしてリンクを貼り直す。
REM 使い方
REM 共有したいファイルを FILE 変数に空白区切りで記入する。
REM Dropboxなどで共有しているディレクトリにこのバッチファイルを配置して実行する。
REM 共有ディレクトリと同じ場所にこのバッチファイルを配置したくなければ、SHARE_DIR 変数に共有ディレクトリの場所を指定する。
REM 管理者権限が不要で済むように、シンボリックではなくハードリンクを使っている。

SETLOCAL
SET FILE=config1.db user_dictionary.db
SET OS_DIR=%USERPROFILE%\AppData\LocalLow\Google\Google Japanese Input
SET SHARE_DIR=.

FOR %%F IN (%FILE%) DO (
  ROBOCOPY /xo "%OS_DIR%" "%SHARE_DIR%" "%%F"
  DEL "%OS_DIR%\%%F"
  MKLINK /H "%OS_DIR%\%%F" "%SHARE_DIR%\%%F"
)
ENDLOCAL

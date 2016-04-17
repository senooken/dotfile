#!/bin/bash
# \file      relink_mozc.sh
# \author    SENOO, Ken
# \copyright CC0
# \date      first created date: 2016-04-17T14:35+09:00
# \date      last  updated date: 2016-04-18T00:12+09:00
# \brief     mozcのIME設定を更新後，共有ディレクトリに更新された設定ファイルをコピーしてリンクを貼り直す。
# 共有したいファイルを FILE 変数に空白区切りで記入する。
# Dropboxなどで共有しているディレクトリにこのスクリプトを配置して実行する。
# 共有ディレクトリと同じ場所にこのスクリプトを配置したくなければ，SHARE_DIR 変数に共有ディレクトリの場所を指定する
# CygwinなどWindowsでの動作も考慮して，管理者権限が不要なハードリンクを使用。

FILE="config1.db user_dictionary.db"
OS_DIR=~/.mozc
SHARE_DIR=.

for f in ${FILE};
do
  rsync -a --include "$f" --exclude "*" "${OS_DIR}/" "${SHARE_DIR}/"
  rm "${OS_DIR}/$f"
  ln -f "${SHARE_DIR}/$f" "${OS_DIR}/"
done

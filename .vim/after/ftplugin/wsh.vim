" \file      wsh.vim
" \author    SENOO, Ken
" \copyright CC0

if exists("b:did_ftplugin_wsh") | finish | endif
let b:did_ftplugin_wsh = 1

if exists('&ofu')
  setlocal ofu=xmlcomplete#CompleteTags
endif

inoremap <buffer> </ </<C-x><C-o>

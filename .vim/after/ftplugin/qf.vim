" \file      qf.vim
" \author    SENOO, Ken
" \copyright CC0

if exists("b:did_ftplugin_qf") | finish | endif
let b:did_ftplugin_qf = 1

" disable line break
nnoremap <buffer> <CR> <CR>

"" open new tab
nnoremap <buffer> t <C-W><CR><C-W>T

" setlocal statusline=%t%<%{exists('w:quickfix_title')?''.w:quickfix_title\ :''}%=%-15(%l,%c%V%)%P
setlocal statusline+=[%n]

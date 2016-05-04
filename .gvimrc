"" MS Windows like keybind
source $VIMRUNTIME/mswin.vim

"" insert breakline on cursor
nnoremap <CR> i<CR><ESC>

set number	" show line number
"" font
try
  if has("gui_gtk2")
    set guifont=Migu\ 1M\ 9
  elseif has("gui_win32")
    set guifont=Migu_1M:h9
  endif
catch /^Vim\%((\a\+)\)\=:E596/  " catch 'error E596: Invalid font(s):'
endtry

set textwidth=0
set formatoptions=q

nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

"" 改行文字を表示
set lcs=tab:›\ ,trail:␣,extends:»,precedes:«,nbsp:%

"" disable foding in gvim
set foldmethod=manual

colorscheme morning
" set guioptions+=b " nowrapのときに横スクロールバー

"" MS Windows like keybind
source $VIMRUNTIME/mswin.vim

set number	" show line number
"" font
if has("gui_gtk2")
  set guifont=Migu\ 1M\ 9
elseif has("gui_win32")
  set guifont=migu_1m:h9  "font
endif
"set guifont=ipagothic:h12  "font
set textwidth=0
set formatoptions=q

nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>
t_startup = 1
set noundofile

"" 改行文字を表示
set lcs=tab:›\ ,trail:␣,extends:»,precedes:«,nbsp:%

"" disable foding in gvim
set foldmethod=manual

colorscheme morning
" set guioptions+=b " nowrapのときに横スクロールバー

"" MS Windows like keybind
source $VIMRUNTIME/mswin.vim

set number  " show line number
"" font
if has('gui_win32')
  set guifont=Migu_1M:h9, HGGothicM:h9
elseif has('gui_gtk2')
  " set guifont=Migu\ 1M\ 9, TakaoGothic\ 9 , VL\ Gothic\ 9 " not work. bug?
  if     system('fc-list | grep -c "Migu 1M"'    ) > 0
    set guifont=Migu\ 1M\ 9
  elseif system('fc-list | grep -c "TakaoGothic"') > 0
    set guifont=TakaoGothic\ 9
  elseif system('fc-list | grep -c "VL Gothic"'  ) > 0
    set guifont=VL\ Gothic\ 9
  endif
endif

set textwidth=0
set formatoptions=q

nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

"" 改行文字を表示
set lcs=tab:›\ ,trail:␣,extends:»,precedes:«,nbsp:%

"" disable foding in gvim
set foldmethod=manual

colorscheme morning
" set guioptions+=b " nowrapのときに横スクロールバー

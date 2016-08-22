"" \file      .gvimrc
"" \author    SENOO, Ken
"" \copyright CC0

"" MS Windows like keybind
source $VIMRUNTIME/mswin.vim

set number
"" font
let s:MYFONT = 'Migu 1M'
let s:MYFS   = '9'
if has('gui_win32')
  let &guifont     = s:MYFONT . ':h' . s:MYFS . ', Consolas:h'  . s:MYFS
  let &guifontwide = s:MYFONT . ':h' . s:MYFS . ', HGGothicM:h' . s:MYFS
  let &guifontwide.= ', MS_Gothic:h' . s:MYFS
elseif has('gui_gtk2')
  " set guifont=Migu\ 1M\ 9, DejaVu\ Sans\ Mono\ 9  " not work. bug?
  " set guifontwide=Migu\ 1M\ 9, TakaoGothic\ 9 , VL\ Gothic\ 9 " not work. bug?
  let &guifont = 'DejaVu Sans Mono ' . s:MYFS
  if     system('fc-list | grep -c ' . shellescape(s:MYFONT)) > 0
    let &guifont     = s:MYFONT . ' ' . s:MYFS
  elseif system('fc-list | grep -c "TakaoGothic"'           ) > 0
    let &guifontwide = 'TakaoGothic ' . s:MYFS
  elseif system('fc-list | grep -c "VL Gothic"'             ) > 0
    let &guifontwide = 'VL Gothic '   . s:MYFS
  endif
endif

set textwidth=0
set formatoptions=q

nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

"" disable foding in gvim
set foldmethod=manual

" set guioptions+=b " nowrapのときに横スクロールバー

"" \file      .vimrc
"" \author    SENOO, Ken
"" \copyright CC0

"" Constant variable
""" Platform
let s:IS_WINDOWS   = has('win64') || has('win32')   || has('win16')
let s:IS_CYGWIN    = has('win32unix')
let s:IS_MAC       = has('mac')   || has('macunix') || has('gui_macvim')
let s:IS_LINUX     = has('unix')  && !s:IS_MAC      && !s:IS_CYGWIN
let s:IS_WINDOWS_7 = s:IS_WINDOWS && system('VER') =~# 'Version 6.1'

"" Encoding
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,utf-8,euc-jp,cp932,cp1252
set fileformats=unix,dos,mac

"" Windowsのコマンドプロンプトの日本語文字化け対策
if s:IS_WINDOWS | set termencoding=cp932 | endif

set ambiwidth=double " show full width

if exists('+fixendofline')  " version 7.4.785+
  autocmd BufWritePre * setlocal nofixendofline
endif

augroup main
  autocmd!
augroup END

"" Fix 'fileencoding' to use 'encoding' if the buffer only ASCII characters.
autocmd main BufReadPost *
  \   if &modifiable && !search('[^\x00-\x7F]', 'cnw')
  \ |   setlocal fileencoding=utf-8
  \ | endif

if has('vim_starting')
  if match(&runtimepath, expand('~/.vim')) == -1
    set runtimepath& runtimepath+=~/.vim,~/.vim/after
    if exists('+packpath')
      set packpath& packpath+=~/.vim
    endif
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif


"" Netrw
let g:netrw_liststyle=3

"" Extend default Vim %
runtime macros/matchit.vim
runtime ftplugin/man.vim

"2013/01/29 http://wikiwiki.jp/mira/?cygwin%2F%B4%C4%B6%AD%B9%BD%C3%DB%2F.vimrc
"-----------------------------------------------------------------------------
" 一般
set history=100 " Command and search history

"" View
set nonumber   " 行番号を表示/非表示
set ruler      " Show ruler
set nolist     " タブや改行を表示しない
set showcmd    " Show inputting command and counting visual mode
set showmatch  " 括弧入力時の対応する括弧を表示
set showmode   " 現在のモードを表示

set nomodeline
set modelines=0
"" Base color
filetype plugin indent on " valid vim plugin
syntax enable

"" In Windows 7, cmd.exe black color cannot work.
if s:IS_WINDOWS_7
  highlight StatusLine ctermfg=DarkBlue  " for black color
endif

"" Statusline
set laststatus=2
set statusline =[%n]%<%f    " File name
set statusline+=\ %m%r%h%w  " Flag for modified, readonly, help buffer, preview
set statusline+=%<%y        " filetype
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " Encoding
set statusline+=%{&bomb?'[bomb]':''}   " BOM
set statusline+=%{&eol?'':'[noeol]'}   " EOL
set statusline+=[%04B]                 " Character code
set statusline+=%=\ %4l/%4L\|%3v\|%4P  " Current position information

"" Tabpage
" set tabline+=[%n]

"" Statusline color
highlight StatusLine cterm=bold ctermfg=White ctermbg=DarkBlue
highlight StatusLine   gui=bold   guifg=White   guibg=DarkBlue

if exists('##ColorScheme')
  autocmd ColorScheme * hi StatusLine cterm=bold ctermfg=White ctermbg=DarkBlue
  autocmd ColorScheme * hi StatusLine   gui=bold   guifg=White   guibg=DarkBlue
  autocmd InsertEnter * hi StatusLine cterm=bold ctermfg=White ctermbg=DarkGreen
  autocmd InsertEnter * hi StatusLine   gui=bold   guifg=White   guibg=DarkGreen
  autocmd InsertLeave * hi StatusLine cterm=bold ctermfg=White ctermbg=DarkBlue
  autocmd InsertLeave * hi StatusLine   gui=bold   guifg=White   guibg=DarkBlue
endif

"" highglight 80 times column
if exists('+colorcolumn')
  let &colorcolumn = '80,160,240,320,400'  " join(range(80,400,80), ',')
  highlight ColorColumn ctermbg=LightRed guibg=LightRed
endif

"" highlight cursorline
" set cursorcolumn
if exists('+cursorline')
  set cursorline  " hightlight cursor line
  highlight CursorLine cterm=NONE ctermbg=LightCyan guibg=LightCyan
endif

" 編集、文書整形関連
" tabが挿入されるとときにshiftwidthを使う
set smarttab
set expandtab
"set noexpandtab
" Tab文字を画面上の見た目で何文字幅にするか設定
set tabstop=2
" cindentやautoindent時に挿入されるタブの幅
set shiftwidth=2
" Tabキー使用時にTabでは無くホワイトスペースを入れたい時に使用する
" この値が0以外の時はtabstopの設定が無効になる
set softtabstop=0
" Tab文字を空白に置き換えない
set textwidth=0 " Prevent auto line break

"" Auto creating file
""" Swap file
if s:IS_WINDOWS
  set directory=$TMP//,.
else
  set directory=/tmp//,~/tmp//,.
endif

set nobackup

if has('persistent_undo')
  set noundofile
  set undodir=~/.vim/tmp
endif

"" File
set autoread  " 更新時自動読み込み
set hidden    " 編集中でも他のファイルを開けるようにする
set autoindent smartindent       " 自動インデント、スマートインデント
" オートインデントを有効にする
set cindent
set backspace=indent,eol,start   " バックスペースで特殊記号も削除可能に
set whichwrap=b,s,h,l,<,>,[,],~  " カーソルを行頭、行末で止まらないようにする
"set clipboard=unnamed,autoselect " バッファにクリップオードを利用する

"" Add executable permission for shebang and Desktop files
autocmd BufWritePost * :call s:Add_execmod()
function! s:Add_execmod()
  let s:line = getline(1)
  if strpart(s:line, 0, 2) == '#!' || &filetype =~# 'desktop\|sh'
    if s:IS_WINDOWS
      call system('icacls '      . shellescape(expand('%') . ' /grant ' . $USERNAME . ':(X)'))
    else
      call system('chmod +x -- ' . shellescape(expand('%')))
    endif
  endif
endfunction

"" open browser by double click
"function! Browser () 
"    let line = getline (".")
"    let line = matchstr (line, "http[^ ]*") 
"    exec "!start \"C:\\Program Files\\Mozilla Firefox\\firefox.exe\"" line
"endfunction
"map <2-LeftMouse> :echo "double click"<CR>


"" Search
set nowrapscan
set ignorecase
set smartcase
set hlsearch

"" Menu
if exists('+wildignorecase')  " Required Vim 7.3.072+
  set wildignorecase         " Ignore case in file name menu completion.
endif
runtime! menu.vim
set wildmenu
set wildmode=list:longest,full  " 1回目で共通部分，2回目で順番に補完
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>


" Command mode keybind.
"map <c-a> <HOME>
noremap <C-e> <END>
noremap <m-d> dw
"" For mouse key
noremap   <Up>      k
noremap   <Down>    j
noremap   <Left>    h
noremap   <Right>   l

"map <c-u> d0
"map <c-k> d$
" When insert mode, enable hjkl and go to home/end.
inoremap <C-e> <END>
inoremap <C-a> <HOME>
inoremap <M-h> <LEFT>
inoremap <M-j> <DOWN>
inoremap <M-k> <UP>
inoremap <M-l> <RIGHT>

inoremap <C-d> <delete>
inoremap <C-b> <C-g>u<C-h>

"" Handle tmux HOME and End key in vim
noremap <Esc>OH <Home>
noremap! <Esc>OH <Home>
noremap <Esc>OF <End>
noremap! <Esc>OF <End>

" noremap <Esc>[5~ <PageUp>
" noremap <Esc>[6~ <PageDown>

" inoremap <expr> = smartchr#loop('=', ' = ', ' == ')

"" short cut for help
nnoremap <C-h> :<C-u>help<Space>
" nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR> " search word in help

"" Insert line break by Enter in normal mode
autocmd main BufWinEnter *
  \  if &modifiable
  \|   nnoremap <buffer> <CR> i<CR><ESC>
  \| else
  \|   silent! nunmap <buffer> <CR>
  \| endif

"" move window
nnoremap <ESC>h <C-w>h
nnoremap <ESC>j <C-w>j
nnoremap <ESC>k <C-w>k
nnoremap <ESC>l <C-w>l

"" Tab page
nnoremap <C-Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprevious<CR>

"" Allow saving of files as sudo
" cabbrev w!! %!sudo tee > /dev/null %
cnoremap w!! %!sudo tee >&- %

"" コマンドラインモードでEmacsのキー移動
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" cnoremap <expr> / (getcmdtype() == '/') '\/' : '/'

nnoremap <BS> X
nnoremap Q gq

"" Move last file position by $VIMRUNTIME/vimrc_example.vim
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
  \  if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

"" cd editting file directory.
autocmd main BufEnter * if finddir(expand('%:p:h')) != '' | lcd %:p:h | endif

set nrformats=   " deal as decimal for number

"" show special character
if v:version >= 700
  set listchars=tab:›\ ,trail:␣,extends:»,precedes:«,nbsp:%
else
  set listchars=tab:>-,trail:_,extends:),precedes:(
endif
set list

"" Word wrap
set linebreak " 空白などいい感じの場所で折り返し
set showbreak=+\  " 折り返し後の行頭記号
if exists('+breakindent')  " version 7.4.338 or later
  set breakindent " 折り返された部分もインデント
endif

""" 全角スペースの表示
highlight ZenkakuSpace ctermbg=red guibg=#666666
autocmd BufWinEnter,WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

" """ ドラッグドロップで新しいタブでファイルを開く
" autocmd VimEnter * tab all
" autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

"" Language
set path&
let s:cpath = ''
for s:dir in split($CPATH, ":")
  let s:cpath .= ',' . s:dir . '/*,'
  " let s:cpath .= substitute(glob(s:dir . "/*/"), "\n", ",", "g")
endfor
let &path .= s:cpath

""" AsciiDoc
autocmd BufRead,BufNewFile *.adoc,*.asciidoc,*.ad setlocal filetype=asciidoc

""" Visual Basic
autocmd BufNewFile,BufRead *.bas setlocal filetype=vb shiftwidth=4 tabstop=4
autocmd BufWritePre *.bas setlocal fileencoding=cp932

""" Bat file
autocmd FileType dosbatch setlocal fileformat=dos fileencoding=cp932
" autocmd FileType javascript setlocal fileencoding=utf-16le

""" Snippet file
autocmd BufNewFile,BufRead *.snip setlocal noexpandtab

autocmd! FileType php,python setlocal shiftwidth=4 tabstop=4 expandtab
autocmd! FileType sh setlocal noexpandtab

"" folding
" autocmd FileType python :set foldmethod=indent
autocmd FileType python setlocal foldlevel=1 foldnestmax=2
autocmd FileType * setlocal formatoptions-=ro

"" 閉じタグの自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml   inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html  inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

"" Binary
"バイナリ編集(xxd)モード（vim -b での起動、または *.bin ファイルを開くと発動）
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre   *.bin let &binary=1
  autocmd BufReadPost  *     if  &binary && &modifiable | silent %!xxd -g 1
  autocmd BufReadPost  *     set filetype=xxd | endif
  autocmd BufWritePre  *     if  &binary      | execute '%!xxd -r' | endif
  autocmd BufWritePost *     if  &binary      | silent   %!xxd -g 1
  autocmd BufWritePost *     set nomod        | endif
augroup END


"" QuickFix
""" Quickfix is available from v6.0 at least
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>

if exists('##QuickfixCmdPre')
  " autocmd QuickfixCmdPre  * tabnew
  " autocmd QuickfixCmdPost * lwindow
  nnoremap [l :lprevious<CR>
  nnoremap ]l :lnext<CR>
  nnoremap [L :lfirst<CR>
  nnoremap ]L :llast<CR>

  "" Vim grep
  """ Ignored files in :vimgrep
  let s:ignore_list = ',.git/**,.svn/**,obj/**'
  let s:ignore_list = s:ignore_list . ',tags,GTAGS,GRTAGS,GPATH'
  let s:ignore_list = s:ignore_list . ',*.o,*.obj,*.exe,*.dll,*.bin,*.so,*.img'
  let s:ignore_list = s:ignore_list . ',*.a,*.out,*.jar,*.pak,*.deb,*.rpm,*.iso'
  let s:ignore_list = s:ignore_list . ',*.zip,*gz,*.xz,*.bz2,*.7z,*.lha,*.lzh'
  let s:ignore_list = s:ignore_list . ',*.png,*.jp*,*.gif,*.tif*,*.bmp,*.mp*'
  let s:ignore_list = s:ignore_list . ',*.pdf,*.od*,*.doc*,*.xls*,*.ppt*'

  if exists('+wildignore')
    autocmd QuickFixCmdPre  * execute 'setlocal wildignore+=' . s:ignore_list
    autocmd QuickFixCmdPost * execute 'setlocal wildignore-=' . s:ignore_list
  endif
endif

"" External grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --column\ $*
  set grepformat=%f:%l:%c:%m
elseif executable('grep')
  set grepprg=grep\ -Rn
elseif executable('findstr')
  set grepprg=findstr\ /n\ /s
endif

"" tags
if has('path_extra')
  set tags& tags+=tags;
endif

nnoremap [t :tprevious<CR>
nnoremap ]t :tnext<CR>
nnoremap [T :tfirst<CR>
nnoremap ]T :tlast<CR>
nnoremap <C-]> g<C-]>

"" cscope
if has('cscope')
  set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
  if v:version >= 800 || has('patch-7.4.1952')
    let &cscopequickfix .= ',a-'
  endif
  set cscopetag
  set cscoperelative

  if executable('cscope')
    if filereadable('cscope.out')
      execute 'cscope add cscope.out ' . expand('%:p:h') . ' -C'
    elseif filereadable($CSCOPE_DB)
      execute 'cscope add $CSCOPE_DB ' . matchstr($CSCOPE_DB, '.*[/\\]') . ' -C'
    endif
  endif
  set cscopeverbose

  """ Search word under cursor. Nul = C-Space
  let s:map = 'nnoremap <silent> '
  for s:type in ['s', 'g', 'd', 'c', 't', 'e', 'f', 'i', 'a']
    if s:type ==# 'f' || s:type ==# 'i'
      let s:target = ' find ' . s:type . ' <C-R>=expand("<file>")<CR><CR>'
    else
      let s:target = ' find ' . s:type . ' <C-R>=expand("<cword>")<CR><CR>'
    endif
    execute s:map '<C-\>'      . s:type . ' :lcscope'      . s:target
    execute s:map '<Nul>'      . s:type . ' :scscope'      . s:target
    execute s:map '<Nul><Nul>' . s:type . ' :vert scscope' . s:target
  endfor
endif

"" template file
autocmd main BufNewFile * silent! :0r  ~/.vim/template/template.%:e
autocmd main BufNewFile * silent! :0r  ~/.vim/template/%:t

"" Buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"" mouse
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif has('mouse_urxvt')
    set ttymouse=urxvt
  else
    set ttymouse=xterm2
  endif

  "" Enter insert/normal/Command-line modes from mouse.
  nnoremap <RightMouse><LeftMouse> :
  inoremap <LeftMouse><RightMouse> <ESC>
  autocmd main BufEnter *
    \  if &modifiable
    \|   nnoremap <buffer> <LeftMouse><RightMouse> i
    \| endif
endif

"" Enable alias for external command
if filereadable($ENV)
  let $BASH_ENV = expand($ENV)
endif

"" Additional .vimrc
if has('gui_running')
  runtime! .gvimrc
endif

runtime! plugin.vim


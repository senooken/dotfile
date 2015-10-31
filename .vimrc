"" \file.vimrc
"" \author SENOO, Ken

"" constant variable
let s:FALSE = 0
let s:TRUE = !s:FALSE

"" platform
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_msys = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \    (!executable('xdg-open') &&
      \    system('uname') =~? '^darwin'))
let s:is_linux = !s:is_mac && has('unix')

"" Charset, Line ending
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
" if s:is_msys || s:is_cygwin
"   set termencoding=cp932
" endif

set ambiwidth=double " 全角記号をきちんと表示

" Fix 'fileencoding' to use 'encoding'
" if the buffer only contains 7-bit characters.
" Note that if the buffer is not 'modifiable',
" its 'fileencoding' cannot be changed, so that such buffers are skipped.
autocmd BufReadPost *
  \   if &modifiable && !search('[^\x00-\x7F]', 'cnw')
  \ |   setlocal fileencoding=
  \ | endif

"" 文字エンコーディングUTF-16のときはbombを付ける
autocmd BufWritePre *
  \   if &fileencoding =~? 'utf-16*'
  \ |   setlocal bomb
  \ | endif

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let s:is_neobundle_installed = s:TRUE
try
  " specify plugin installation base directory.
  call neobundle#begin(expand('~/.vim/bundle/'))
catch /^Vim\%((\a\+)\)\=:E117/	" catch error E117: Unkown function
  let s:is_neobundle_installed = s:FALSE
  set title titlestring=NeoBundle\ is\ not\ installed!
endtry

function! s:neobundled(bundle)
  return s:is_neobundle_installed && neobundle#is_installed(a:bundle)
endfunction

if s:is_neobundle_installed
    " Let NeoBundle manage NeoBundle
    NeoBundleFetch 'Shougo/neobundle.vim'

  "" list installing plugins
  if has("lua")
    NeoBundle 'Shougo/neocomplete'
  else
    NeoBundle 'Shougo/neocomplcache'
  endif

  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'honza/vim-snippets'
  NeoBundle 'garbas/vim-snipmate' , {'depends' :
        \ [ 'MarcWeber/vim-addon-mw-utils',
        \   'tomtom/tlib_vim']
        \ }

  " NeoBundle 'kana/vim-smartinput'

  " NeoBundle 'mattn/emmet-vim'
  NeoBundle 'Shougo/neomru.vim'

  "" code highlight
  NeoBundleLazy 'vim-jp/cpp-vim', { 'autoload': {'filetypes' : 'cpp'}}
  NeoBundleLazy 'asciidoc.vim', {"autoload" : {"filetypes" : "asciidoc"}}

  "" Install clang_complete
  " NeoBundle 'Rip-Rip/clang_complete'
  " NeoBundle 'davidhalter/jedi-vim'

  NeoBundle 'Shougo/vimfiler', {'depends': 'Shougo/unite.vim'} " file manage
  NeoBundle 'thinca/vim-fontzoom' " change font size easy

  NeoBundle 'kana/vim-smartchr'
  " NeoBundle 'kana/vim-submode'

  if has('gui_running')
    NeoBundle 'istepura/vim-toolbar-icons-silk' " cool gvim toolbar icon
  endif
  NeoBundle 'nathanaelkane/vim-indent-guides' " clearly indent

  "" text edit
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'Align'
  NeoBundle 'YankRing.vim'

  " NeoBundle 'tyru/open-browser'
  " NeoBundle 'kannokanno/previm'
  " NeoBundle 'plasticboy/vim-markdown'

  NeoBundle 'autodate.vim'
  NeoBundle 'lamsh/autofname.vim'
  " NeoBundle 'Shougo/vimproc', {
  "   \ 'build' : {
  "   \    'windows': 'echo "Sorry, cannot update vimproc binary file in Windows."',
  "   \    'cygwin' : 'make -f make_cygwin.mak',
  "   \    'mac' : 'make -f make_mac.mak',
  "   \    'unix' : 'make -f make_unix.mak',
  "   \   },
  "   \ }

  NeoBundle 'thinca/vim-quickrun' " quick run in vim

  NeoBundle 'gtags.vim'
  NeoBundle 'vim-jp/vimdoc-ja'
  NeoBundle 'tyru/caw.vim' " comment out
  NeoBundle 'Lokaltog/vim-easymotion' " cursor
  call neobundle#end()
  filetype plugin indent on " valid vim plugin
  " NeoBundleCheck " I'm not prefered checking.
endif

if s:neobundled('neocomplete')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'
  "" C++
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.cpp =
        \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
endif

if s:neobundled('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_ignore_case = 1
  let g:neocomplcache_enable_smart_case = 1
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns._ = '\h\w*'
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
endif

if s:neobundled('neosnippet')
  " Tell Neosnippet about the other snippets
  "let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
  let g:neosnippet#snippets_directory='~/.vim/snippet,~/.vim/bundle/vim-snippets'
  " Plugin key-mappings.  " <C-f>でsnippetの展開
  "imap <C-k> <Plug>(neosnippet_expand_or_jump)
  " imap <expr><CR> !pumvisible()? "" : neosnippet#expandable() ? "\<Plug>(neosnippet_expand)": neocomplete#close_popup()
  imap <C-f> <Plug>(neosnippet_expand_or_jump)
  smap <C-f> <Plug>(neosnippet_expand_or_jump)
  xmap <C-f> <Plug>(neosnippet_expand_target)
  " SuperTab like snippets bEHAVIr.
    imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
  endif

if s:neobundled('vim-smartinput')
  "   "" 空白文字以外のときは勝手に補間させない
  "   call smartinput#define_rule({
  "     \ 'at': '\%#\S', 'char': '(', 'input': '(' })
  "   call smartinput#define_rule({
  "     \ 'at': '\%#\S', 'char': ')', 'input': ')' })
  "   call smartinput#define_rule({
  "     \ 'at': '\%#\S', 'char': '[', 'input': '[' })
  "   call smartinput#define_rule({
  "     \ 'at': '\%#\S', 'char': ']', 'input': ']' })
  "   call smartinput#define_rule({
  "     \ 'at': '\%#\S', 'char': '{', 'input': '{' })
  "   call smartinput#define_rule({
  "     \ 'at': '\%#\S', 'char': '}', 'input': '}' })
  "
  "   "" C++でstruct, class, enum+{の入力後に;を追記
  "   call smartinput#define_rule({
  "     \   'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
  "     \   'char'     : '{',
  "     \   'input'    : '{};<Left><Left>',
  "     \   'filetype' : ['cpp'],
  "     \   })
  "   call smartinput#map_to_trigger('i', ':', ':', ':')
  "   " call smartinput#define_rule({
  "   "             \   'at'       : ':\%#',
  "   "             \   'char'     : ':',
  "   "             \   'input'    : '<BS>::',
  "   "             \   'filetype' : ['cpp'],
  "   "             \   })
  "   "" s:: -> std::, b:: -> boost::
  "   "" boost:: の補完
  "   call smartinput#define_rule({
  "     \   'at'       : '\<b:\%#',
  "     \   'char'     : ':',
  "     \   'input'    : '<BS>oost::',
  "     \   'filetype' : ['cpp'],
  "     \   })
  "   " std:: の補完
  "   call smartinput#define_rule({
  "     \   'at'       : '\<s:\%#',
  "     \   'char'     : ':',
  "     \   'input'    : '<BS>td::',
  "     \   'filetype' : ['cpp'],
  "     \   })
  "   " detail:: の補完
  "   call smartinput#define_rule({
  "     \   'at'       : '\%(\s\|::\)d:\%#',
  "     \   'char'     : ':',
  "     \   'input'    : '<BS>etail::',
  "     \   'filetype' : ['cpp'],
  "     \   })
endif

if s:neobundled('unite.vim')
    let g:unite_source_history_yank_enable=1
    nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
    nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
endif

if s:neobundled('neomru.vim')
    let g:neomru#time_format = "[%Y%m%dT%H%M] "
    let g:unite_source_file_mru_limit = 200
    nnoremap <silent> ,ur :<C-u>Unite file_mru<CR>
endif

  augroup cpp-path
      autocmd!
      autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/usr/lib/c++/v1
  augroup END

if s:neobundled('vim-submode')
  "   let g:clang_periodic_quickfix = 1
  "   let g:clang_complete_copen = 1
  "   let g:clang_use_library = 1
  "
  "   " this need to be updated on llvm update
  "   let g:clang_library_path = '/usr/lib/llvm-3.4/lib'
  "   " specify compiler options
  "   let g:clang_user_options = '-std=c++11 -stdlib=libc++'
endif

if s:neobundled('vim-submode')
  "   "" ウィンドウサイズ変更
  "   call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  "   call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  "   call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
  "   call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
  "   call submode#map('winsize', 'n', '', '>', '<C-w>>')
  "   call submode#map('winsize', 'n', '', '<', '<C-w><')
  "   call submode#map('winsize', 'n', '', '+', '<C-w>-')
  "   call submode#map('winsize', 'n', '', '-', '<C-w>+')
  "   "" タブページ切り替え
  "   call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
  "   call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
  "   call submode#map('changetab', 'n', '', 't', 'gt')
  "   call submode#map('changetab', 'n', '', 'T', 'gT')
  "   "" undo/redoを巡る
  "   call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
  "   call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
  "   call submode#map('undo/redo', 'n', '', '-', 'g-')
  "   call submode#map('undo/redo', 'n', '', '+', 'g+')
endif

if s:neobundled('vim-indent-guides')
    "" vim-indent-guides'
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2 " start indent column
    let g:indent_guides_auto_colors = 0
    "" 奇数インデントのカラー
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
    "" 偶数インデントのカラー
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=yellow " darkgray
    let g:indent_guides_color_change_percent  =  30 " width of changing highlight color
    let g:indent_guides_guide_size = 1 " indent guide size
endif

if s:neobundled('autodate.vim')
    let autodate_keyword_pre='\\date'
    let autodate_keyword_post='$'
    let autodate_format="%Y-%m-%dT%H:%M+09:00"
    let autodate_lines=10
endif

if s:neobundled('autofname.vim')
    let autofname_keyword_pre='\\file'
    let autofname_keyword_post='$'
    let autofname_lines=10
endif

if s:neobundled('vim-quickrun')
    let g:quickrun_config = {} " initialization
    "" default option
    let g:quickrun_config._ = {
    \ 'runner' : 'vimproc',
    \ 'runner/vimproc/updatetime': 10,
    \ 'split': '',
    \ }

    let g:quickrun_config.fortran = {'cmdopt': '-Wall -O3 -static'}
    let g:quickrun_config.cpp = {'cmdopt': '-Wall'}
    let g:quickrun_config.c = {'cmdopt': '-Wall -std=gnu11'}

    set splitbelow
    " set splitright
endif

if s:neobundled('caw.vim')
    " コメントアウトを切り替えるマッピング
    " \c でカーソル行をコメントアウト  再度 \c でコメントアウトを解除
    nmap \c <Plug>(caw:i:toggle)
    vmap \c <Plug>(caw:i:toggle)

    " \C でコメントアウトの解除
    nmap \C <Plug>(caw:I:uncomment)
    vmap \C <Plug>(caw:I:uncomment)
endif

if s:neobundled('vim-easymotion')
    let g:EasyMotion_do_mapping = 0
    nmap s <Plug>(easymotion-s2)
    xmap s <Plug>(easymotion-s2)
    omap z <Plug>(easymotion-s2)
    " Turn on case sensitive feature
    let g:EasyMotion_smartcase = 1
    " `JK` Motions: Extend line motions
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    " keep cursor column with `JK` motions
    let g:EasyMotion_startofline = 0
    map f <Plug>(easymotion-fl)
    " =======================================
    " General Configuration
    " =======================================
    let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
    " Show target key with upper case to improve readability
    let g:EasyMotion_use_upper = 1
    " Jump to first match with enter & space
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_space_jump_first = 1

    " =======================================
    " Search Motions
    " =======================================
    " Extend search motions with vital-over command line interface
    " Incremental highlight of all the matches
    " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
    " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
    " :h easymotion-command-line
    nmap g/ <Plug>(easymotion-sn)
    xmap g/ <Plug>(easymotion-sn)
    omap g/ <Plug>(easymotion-tn)

    map t <Plug>(easymotion-tl)
    map F <Plug>(easymotion-Fl)
    map T <Plug>(easymotion-Tl)
endif

"" Extend default Vim %
source $VIMRUNTIME/macros/matchit.vim

""" vimfiler
"" autocmd VimEnter * VimFiler -split -simple -winwidth=25 -no-quit " look like
"" IDE explore on startup
"let g:vimfiler_as_default_explorer  = 1 
"let g:vimfiler_safe_mode_by_default = 0
"let g:netrw_liststyle=3


"2013/01/29 http://wikiwiki.jp/mira/?cygwin%2F%B4%C4%B6%AD%B9%BD%C3%DB%2F.vimrc
"-----------------------------------------------------------------------------
" 一般
"
" コマンド、検索パターンを50個まで履歴に残す
set history=50
" 装飾関連
"
"行番号を表示/非表示
"set number
set nonumber

" ルーラーを表示
set ruler
" タブや改行を表示しない
set nolist
" 入力中のコマンドをステータスに表示する
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2

" ステータスラインに表示する情報の指定
set statusline=%<%f\ %m%r%h%w " ファイル名
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'.'['.&ft.']'} " 改行コードなど
set statusline+=[\%04.4B] " カーソル行の16進数文字コード
set statusline+=%=%l/%L,\ %c%V%8P " 現在位置の情報

" ステータスラインの色
hi StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white
" ハイライト
if &t_Co > 2 || has("gui_running")
  " シンタックスハイライトを有効にする
  syntax on
  " 検索結果文字列のハイライトを有効にする
  set hlsearch
endif
"-----------------------------------------------------------------------------
" 編集、文書整形関連
"
" backspaceキーの挙動を設定する
" indent	: 行頭の空白の削除を許す
" eol		: 改行の削除を許す
" start		: 挿入モードの開始位置での削除を許す
set backspace=indent,eol,start
" 新しい行を直前の行と同じインデントにする
set autoindent
" tabが挿入されるとときにshiftwidthを使う
set smarttab
set expandtab
" Tab文字を画面上の見た目で何文字幅にするか設定
set tabstop=2
" cindentやautoindent時に挿入されるタブの幅
set shiftwidth=2
" Tabキー使用時にTabでは無くホワイトスペースを入れたい時に使用する
" この値が0以外の時はtabstopの設定が無効になる
set softtabstop=0
" Tab文字を空白に置き換えない
"set noexpandtab
" オートインデントを有効にする
set cindent
set textwidth=0 " Prevent auto line break

"" vim auto creating file
set noswapfile
" set directory=~/.vim/tmp
set nobackup
set backupdir=~/.vim/tmp
set noundofile
set undodir=~/.vim/tmp

"File
set autoread	" 更新時自動読み込み
set hidden		" 編集中でも他のファイルを開けるようにする
syntax on		" シンタックスカラーリングオン
set autoindent smartindent	" 自動インデント、スマートインデント
set backspace=indent,eol,start	" バックスペースで特殊記号も削除可能に
set whichwrap=b,s,h,l,<,>,[,],~	" カーソルを行頭、行末で止まらないようにする
"set clipboard=unnamed,autoselect	" バッファにクリップオードを利用する

"" template file
autocmd BufNewFile ifort.bat silent! :0r  ~/.vim/template/ifort.bat
autocmd BufNewFile * silent! :0r  ~/.vim/template/%:e.tmpl " 拡張子付きのファイルはテンプレから新規作成
autocmd BufNewFile Makefile silent! :0r  ~/.vim/template/Makefile

"" shebangのあるファイルには自動で実行権限を付加
autocmd BufWritePost * :call AddExecmod()
function AddExecmod()
  let line = getline(1)
  if strpart(line, 0, 2) == "#!"
    if has('win32') || has('win64')
      call system("icacls " . expand("%") . " /grant " . $USERNAME . ":(X)")
    else
      call system("chmod +x ". expand("%"))
    endif
  endif
endfunction

if has("win32") || has("win64")
  set shell=cmd
  set shellcmdflag=/c
endif

"" open browser by double click
"function! Browser () 
"    let line = getline (".") 
"    let line = matchstr (line, "http[^ ]*") 
"    exec "!start \"C:\\Program Files\\Mozilla Firefox\\firefox.exe\"" line 
"endfunction 
"map <2-LeftMouse> :echo "double click"<CR> 



" Search
"set wrapscan	" 省略形ws。検索が末尾まで進んだら先頭から再建策。既定値。
set nowrapscan		" 省略形nows。wrapscanをオフにする。
set ignorecase
set smartcase

" View
set showmatch	" 括弧の対応をハイライト
set showcmd		" 入力中のコマンドを表示
set showmode	" 現在のモードを表示
" set cursorcolumn " カーソル列をハイライト
set cursorline	" カーソル行をハイライト

"" other
""" メニュー補完
set wildignorecase " ファイル名とディレクトリの補完で大文字小文字無視
set wildmenu
set wildmode=list:longest,full " 1回目で共通部分，2回目で順番に補完

" color
colorscheme default

""	my config
" Command mode keybind.
"map <c-a> <HOME>
noremap <c-e> <END>
noremap <m-d> dw
"map <c-u> d0
"map <c-k> d$
" When insert mode, enable hjkl and go to home/end.
inoremap <c-e> <END>
inoremap <c-a> <HOME>
inoremap <c-h> <LEFT>
inoremap <c-j> <DOWN>
inoremap <c-k> <UP>
inoremap <c-l> <RIGHT>
inoremap <c-d> <delete>
inoremap <c-b> <c-g>u<c-h>

"" Handle tmux HOME and End key in vim
map <Esc>OH <Home>
map! <Esc>OH <Home>
map <Esc>OF <End>
map! <Esc>OF <End>

" inoremap <expr> = smartchr#loop('=', ' = ', ' == ')

"" short cut for help
nnoremap <C-h> :<C-u>help<Space>
" nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR> " search word in help


"" move window
nnoremap <ESC>h <C-w>h
nnoremap <ESC>j <C-w>j
nnoremap <ESC>k <C-w>k
nnoremap <ESC>l <C-w>l

"" Allow saving of files as sudo
" cabbrev w!! %!sudo tee > /dev/null %
cnoremap w!! %!sudo tee > /dev/null %

"" コマンドラインモードでEmacのキー移動
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


"" move last file position
augroup vimrcEx/d
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

"" 開いたファイルの場所を現在ディレクトリにする
autocmd BufEnter * execute ":lcd " .expand("%:p:h")

set nrformats=   " deal as decimal for number

"" show special character
set listchars=tab:›\ ,trail:␣,extends:»,precedes:«,nbsp:%
" set lcs=tab:►\ ,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
set list

"" 折り返し
set linebreak " 空白などいい感じの場所で折り返し
set showbreak=+\  " 折り返し後の行頭記号
if (v:version == 704 && has("patch338")) || v:version >= 705
  set breakindent " 折り返された部分もインデント
endif

""" 全角スペースの表示
highlight ZenkakuSpace ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

" """ ドラッグドロップで新しいタブでファイルを開く
" autocmd VimEnter * tab all
" autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'

"" language config
""" AsciiDoc

autocmd BufRead,BufNewFile *.adoc,*.asciidoc,*.ad setlocal filetype=asciidoc

""" for Visual Basic
autocmd BufNewFile,BufRead *.bas setlocal filetype=vb shiftwidth=4 tabstop=4
autocmd BufWritePre *.bas setlocal fileencoding=cp932

""" for bat file
autocmd BufWritePre *.bat setlocal fileformat=dos fileencoding=cp932

""" for snippet file
autocmd BufNewFile,BufRead *.snip setlocal noexpandtab

autocmd! FileType python setlocal shiftwidth=4 tabstop=4

"" folding
" autocmd FileType python :set foldmethod=indent
autocmd FileType python :set foldlevel=1
autocmd FileType python :set foldnestmax=2
autocmd FileType * setlocal formatoptions-=ro

"" 閉じタグの自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

"" mouse
set mouse=a
set ttymouse=xterm2

"" 外部コマンドでaliasを使えるようにする
if filereadable(glob('~/.zbashrc'))
  let $BASH_ENV=expand('~/.zbashrc')
endif

"" default vim setting by practical vim 
set nocompatible " viとの互換をとらない
filetype plugin on " valid vim plugin

"Charset, Line ending
set termencoding=utf-8
set encoding=utf-8
"
"" encoding
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932

" file format
 set fileformats=unix,dos,mac


"" manegement of vim plugin
"filetype off

if has('vim_starting')
  "runtimepathにneobundle.vimをインストールしたディレクトリを指定
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
"
" プラグインをインストールする基準となるパスを指定
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

"" list installing plugins
NeoBundle 'Shougo/neocomplcache'
" valid neocomplcache at vim startup
  let g:neocomplcache_enable_at_startup = 1

  " <TAB>: completion.                                         
  "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"   
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 

NeoBundle 'Shougo/neosnippet'
  " Tell Neosnippet about the other snippets
  "let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
  let g:neosnippet#snippets_directory='~/.vim/snippet,~/.vimr/bundle/vim-snippets'
  " Plugin key-mappings.  " <C-k>でsnippetの展開
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  " SuperTab like snippets bEHAVIr.
  imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  
  " For snippet_complete marker.
  if has('conceal')
      set conceallevel=2 concealcursor=i
  endif

NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

NeoBundle 'Shougo/unite.vim'

"NeoBundle 'Shougo/vimfiler'     " file manage
NeoBundle 'thinca/vim-fontzoom' " change font size easy
NeoBundle 'kana/vim-smartchr'
NeoBundle 'istepura/vim-toolbar-icons-silk' " cool gvim toolbar icon
NeoBundle 'nathanaelkane/vim-indent-guides' " clearly indent
NeoBundle 'tpope/vim-surround' 
"NeoBundle 'tyru/open-browser-github'
"

NeoBundle 'autodate.vim' " autodate.vim
  let autodate_keyword_pre="(Last Update:"
  let autodate_keyword_post=")"
  let autodate_format="%Y-%m-%dT%H:%M+09:00"
  let autodate_lines=5


NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'thinca/vim-quickrun' " quick run in vim
  let g:quickrun_config = {
  \  "_": {  
  \    'runner' : 'vimproc',
  \  },
  \}

NeoBundle 'vim-jp/vimdoc-ja'

filetype indent on


""" vimfiler
"" autocmd VimEnter * VimFiler -split -simple -winwidth=25 -no-quit " look like
"" IDE explore on startup
"let g:vimfiler_as_default_explorer  = 1 
"let g:vimfiler_safe_mode_by_default = 0
"let g:netrw_liststyle=3

"" vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2 " start indent column
"let g:indent_guides_auto_colors = 0
"" 奇数インデントのカラー
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
"" 偶数インデントのカラー
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
let g:indent_guides_color_change_percent  =  30 " width of changing highlight color
let g:indent_guides_guide_size = 1 " indent guide size

"" my variable
let $TODAY=strftime('%Y%m%d')

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

" タイトルをウインドウ枠に表示 
" 2013/01/29 notitleにすることで「vimを使ってくれてありがとう」を非表示にする
set notitle
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
"set statusline=%y%{GetStatusEx()}%F%m%r%=<%c:%l>
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
set tabstop=4
" cindentやautoindent時に挿入されるタブの幅
set shiftwidth=4
" Tabキー使用時にTabでは無くホワイトスペースを入れたい時に使用する
" この値が0以外の時はtabstopの設定が無効になる
set softtabstop=0
" Tab文字を空白に置き換えない
"set noexpandtab
" オートインデントを有効にする
set cindent

set textwidth=0 "	Prevent auto line break [130324].
" 2013/02/27

"" vim auto creating file
set noswapfile
"set directory=~/tmp
set nobackup
"set backupdir=~/tmp
set noundofile
"set undodir=$~/tmp

"File
set autoread	" 更新時自動読み込み
set hidden		" 編集中でも他のファイルを開けるようにする
syntax on		" シンタックスカラーリングオン
set autoindent smartindent	" 自動インデント、スマートインデント
set backspace=indent,eol,start	" バックスペースで特殊記号も削除可能に
set whichwrap=b,s,h,s,<,>,[,]	" カーソルを行頭、行末で止まらないようにする
"set clipboard=unnamed,autoselect	" バッファにクリップオードを利用する

"" template file
autocmd BufNewFile * silent! :0r  ~/.vim/template/%:e.tmpl " 拡張子付きのファイルはテンプレから新規作成
autocmd BufNewFile Makefile silent! :0r  ~/.vim/template/Makefile 

"" shebangのあるファイルには自動で実行権限を付加
"autocmd BufWritePost * :call AddExecmod()
"function AddExecmod()
"	let line = getline(1)
"    if strpart(line, 0, 2) == "#!"
"		call system("chmod +x ". expand("%"))
"	endif
"endfunction
"
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
set cursorline	" カーソル行をハイライト


" color 
colorscheme default

""	my config
" Command mode keybind.
"map <c-a> <HOME>
map <c-e> <END>
map <m-d> dw
"map <c-u> d0
"map <c-k> d$
" When insert mode, enable hjkl and go to home/end.
imap <c-e> <END>
imap <c-a> <HOME>
imap <c-h> <LEFT>
imap <c-j> <DOWN>
"imap <c-k> <UP>
imap <m-k> <UP>
imap <c-l> <RIGHT>

"inoremap <expr> = smartchr#loop(' = ', '=', ' == ')
"
"

"" move last file position
augroup vimrcEx
      au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe "normal g`\"" | endif
augroup END


set nrformats=   " deal as decimal for number

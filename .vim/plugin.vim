"" \file      plugin.vim
"" \author    SENOO, Ken
"" \copyright CC0

"" \brief Check if a plugin is installed.
"" \param[in] plugin Plugin name (direcotry name).
"" \return 1: installed, 0: not installed.
function! s:is_plugin_installed(plugin)
  return globpath(&runtimepath, 'pack/*/*/' . a:plugin, 1) != ''
endfunction

if s:is_plugin_installed('vim-mucomplete')
  set completeopt& completeopt+=menuone
  inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
  inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
  inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")
  set completeopt+=noselect
  set completeopt+=noinsert
  set shortmess+=c   " Shut off completion messages
  set belloff+=ctrlg " If Vim beeps during completion
  let g:mucomplete#enable_auto_at_startup = 1
  imap <plug>Unused <plug>(MUcompleteCycBwd)
endif

if s:is_plugin_installed('vim-clang')
  let g:clang_c_option = '-std=gnu11'
  let g:clang_cpp_option = '-std=gnu11 -stdlib=libc++'
endif

if s:is_plugin_installed('caw.vim')
  nmap \c <Plug>(caw:hatpos:toggle)
  vmap \c <Plug>(caw:hatpos:toggle)
  nmap \C <Plug>(caw:zeropos:uncomment)
  vmap \C <Plug>(caw:zeropos:uncomment)
endif

if s:is_plugin_installed('autodate.vim')
  let autodate_keyword_pre='Updated:'
  let autodate_keyword_post='$'
  let autodate_format='%Y-%m-%dT%H:%M+09:00'
  let autodate_lines=10
  "" Disable autodate.vim during editing template
  autocmd BufWritePre template.*  silent! :AutodateOFF
endif

if s:is_plugin_installed('autofname.vim')
  let autofname_keyword_pre=' [\@]file '
  let autofname_keyword_post='$'
  let autofname_lines=5
endif

if s:is_plugin_installed('vim-clurin')
  nmap + <Plug>(clurin-next)
  nmap - <Plug>(clurin-prev)
  vmap + <Plug>(clurin-next)
  vmap - <Plug>(clurin-prev)
  function! s:default_pm(cnt) abort
    if a:cnt >= 0
      execute 'normal!'   a:cnt  . "j0"
    else
      execute 'normal!' (-a:cnt) . "k0"
    endif
  endfunction
  let g:clurin = {
  \   '-': {
  \     'nomatch': function('s:default_pm'),
  \     'def': [
  \       [
  \         {'pattern': '''\(\k\+\)''' , 'replace':  '''\1''' },
  \         {'pattern':  '"\(\k\+\)"'  , 'replace':   '"\1"'  },
  \       ],
  \       ['TRUE', 'FALSE'], ['True', 'False'],
  \       ['ON', 'OFF'], ['on', 'off'], ['On', 'Off'],
  \       ['>', '<'], ['>=','<='], ['>>', '<<'],
  \       ['+', '-'], ['*','/'], ['==', '!='], ['++', '--'],
  \       ['&&', '||'], ['and', 'or'], ['AND', 'OR'],
  \       ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
  \       ['first', 'second', 'third', 'fourth', 'fifth'],
  \       ['FIRST', 'SECOND', 'THIRD', 'FOURTH', 'FIFTH'],
  \       ['First', 'Second', 'Third', 'Fourth', 'Fifth'],
  \       ['foo', 'bar', 'baz'], ['FOO', 'BAR', 'BAZ'], ['Foo', 'Bar', 'Baz'],
  \       ['hoge', 'piyo', 'fuga'], ['HOGE', 'PIYO', 'FUGA'],['Hoge', 'Piyo', 'Fuga'],
  \       ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'],
  \       ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY'],
  \       ['月', '火', '水', '木', '金', '土', '日'],
  \       ['（月）', '（火）', '（水）', '（木）', '（金）', '（土）', '（日）'],
  \       ['月曜', '火曜', '水曜', '木曜', '金曜', '土曜', '日曜'],
  \       ['月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日', '日曜日'],
  \       ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
  \       ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'],
  \       ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
  \       ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'],
  \       ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'],
  \       ['yes', 'no'], ['YES', 'NO'], ['Yes', 'No'], ['OK', 'NG'],
  \       ['begin', 'end'], ['BEGIN', 'END'], ['Begin', 'End'],
  \       ['start', 'stop'], ['START', 'STOP'], ['Start', 'Stop'],
  \       ['first', 'last'], ['FIRST', 'LAST'], ['First', 'Last'],
  \       ['top', 'bottom'], ['TOP', 'BOTTOM'], ['Top', 'Bottom'],
  \       ['before', 'after'], ['BEFORE', 'AFTER'], ['Before', 'After'],
  \       ['left', 'right'], ['LEFT', 'RIGHT'], ['Left', 'Right'],
  \       ['up', 'down'], ['UP', 'DOWN'], ['Up', 'Down'],
  \       ['north', 'south', 'east', 'west'],
  \       ['NORTH', 'SOUTH', 'EAST', 'WEST'],
  \       ['North', 'South', 'East', 'West'],
  \       ['N', 'S', 'E', 'W'],
  \       ['max', 'min'], ['MAX', 'MIN'], ['Max', 'Min'],
  \       ['least', 'most'], ['LEAST', 'MOST'], ['Least', 'Most'],
  \       ['less', 'more'], ['LESS', 'MORE'], ['Less', 'More'],
  \       ['few', 'much'], ['FEW', 'MUCH'], ['Few', 'Much'],
  \       ['in', 'out'], ['IN', 'OUT'], ['In', 'Out'],
  \       ['old', 'new'], ['OLD', 'NEW'], ['Old', 'New'],
  \       ['open', 'close'], ['OPEN', 'CLOSE'], ['Open', 'Close'],
  \       ['read', 'write'], ['READ', 'WRITE'], ['Read', 'Write'],
  \       ['next', 'previous'], ['NEXT', 'PREVIOUS'], ['Next', 'Previous'],
  \       ['English', 'Japanese'], ['en', 'ja'], ['US', 'JP'], ['us', 'jp']
  \     ]
  \   }
  \ }
endif

if s:is_plugin_installed('vim-altr')
  nmap <F2> <Plug>(altr-forward)
  nmap <S-F2> <Plug>(altr-back)
endif


" let s:is_neobundle_installed = v:true
" try " specify plugin installation base directory.
"   call neobundle#begin(expand('~/.vim/bundle/'))
" catch /^Vim(call):E117/  " catch error E117: Unkown function
"   let s:is_neobundle_installed = v:false
"   set title titlestring=NeoBundle\ is\ not\ installed!
" endtry
" 
" 
" if s:is_neobundle_installed
"   "" Let NeoBundle manage NeoBundle
"   NeoBundleFetch 'Shougo/neobundle.vim'
" 
"   "" list installing plugins
"   """ completion
"   if !has("lua")
"     NeoBundle 'Shougo/neocomplcache'
"   endif
" 
"   " NeoBundle 'Shougo/neosnippet'
"   " NeoBundle 'Shougo/neosnippet-snippets'
"   " NeoBundle 'honza/vim-snippets'
"   " NeoBundle 'garbas/vim-snipmate' , {'depends' :
"   "       \ [ 'MarcWeber/vim-addon-mw-utils',
"   "       \   'tomtom/tlib_vim']
"   "       \ }
"   " NeoBundle 'kana/vim-smartinput'
" 
"   " NeoBundle 'mattn/emmet-vim'
"   NeoBundle 'Shougo/neomru.vim'
" 
"   "" language
"   " NeoBundleLazy 'c.vim', { 'autoload': {'filetypes' : ['cpp', 'c']}}
"   NeoBundleLazy 'asciidoc.vim', {"autoload" : {"filetypes" : "asciidoc"}}
" 
"   "" Install clang_complete
"   " NeoBundle 'Rip-Rip/clang_complete'
"   " NeoBundle 'davidhalter/jedi-vim'
" 
"   NeoBundle 'Shougo/vimfiler', {'depends': 'Shougo/unite.vim'} " file manage
"   NeoBundle 'thinca/vim-fontzoom' " change font size easy
" 
"   NeoBundle 'kana/vim-smartchr'
"   NeoBundle 'kana/vim-submode'
" 
"   NeoBundle 'nathanaelkane/vim-indent-guides' " clearly indent
" 
"   "" text edit
"   NeoBundle 'YankRing.vim'
" 
"   " NeoBundle 'tyru/open-browser'
"   " NeoBundle 'kannokanno/previm'
"   " NeoBundle 'plasticboy/vim-markdown'
" 
"   if executable('make') && executable('gcc') && executable('cc')
"     NeoBundle 'Shougo/vimproc.vim', {
"     \ 'build' : {
"     \   'windows': 'tools\\update-dll-mingw',
"     \   'cygwin': 'make -f make_cygwin.mak',
"     \   'mac' : 'make',
"     \   'linux' : 'make',
"     \   'unix' : 'gmake',
"     \   },
"     \ }
"   endif
" 
"   NeoBundle 'thinca/vim-quickrun' " quick run in vim
"   if executable('ctags')
"     NeoBundle 'taglist.vim'
"   endif
" 
"   " NeoBundle 'gtags.vim'
"   NeoBundle 'Lokaltog/vim-easymotion' " cursor
" 
"   NeoBundle 'tacahiroy/ctrlp-funky'
" 
"   call neobundle#end()
"   " NeoBundleCheck " I'm not prefered checking.
" endif
" 
" function! s:Neobundled(bundle)
"   return s:is_neobundle_installed && neobundle#is_installed(a:bundle)
" endfunction
" 
" if s:Neobundled('neocomplcache')
"   let g:neocomplcache_enable_at_startup = 1
"   let g:neocomplcache_enable_ignore_case = 1
"   let g:neocomplcache_enable_smart_case = 1
"   if !exists('g:neocomplcache_keyword_patterns')
"     let g:neocomplcache_keyword_patterns = {}
"   endif
"   let g:neocomplcache_keyword_patterns._ = '\h\w*'
"   let g:neocomplcache_enable_camel_case_completion = 1
"   let g:neocomplcache_enable_underbar_completion = 1
"   inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"   inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
" endif
" 
" if s:Neobundled('neosnippet')
"   " Enable snipMate compatibility feature.
"   let g:neosnippet#enable_snipmate_compatibility = 1
"   " Tell Neosnippet about the other snippets
"   let g:neosnippet#snippets_directory='~/.vim/snippet,~/.vim/bundle/vim-snippets/snippets'
"   " Plugin key-mappings.  " <C-f>でsnippetの展開
"   "imap <C-k> <Plug>(neosnippet_expand_or_jump)
"   " imap <expr><CR> !pumvisible()? "" : neosnippet#expandable() ? "\<Plug>(neosnippet_expand)": neocomplete#close_popup()
"   imap <C-f> <Plug>(neosnippet_expand_or_jump)
"   smap <C-f> <Plug>(neosnippet_expand_or_jump)
"   xmap <C-f> <Plug>(neosnippet_expand_target)
"   " SuperTab like snippets bEHAVIr.
"     imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"     smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" 
"     " For snippet_complete marker.
"     if has('conceal')
"       set conceallevel=2 concealcursor=i
"     endif
"   endif
" 
" if s:Neobundled('vim-smartinput')
"   "   "" 空白文字以外のときは勝手に補間させない
"   "   call smartinput#define_rule({
"   "     \ 'at': '\%#\S', 'char': '(', 'input': '(' })
"   "   call smartinput#define_rule({
"   "     \ 'at': '\%#\S', 'char': ')', 'input': ')' })
"   "   call smartinput#define_rule({
"   "     \ 'at': '\%#\S', 'char': '[', 'input': '[' })
"   "   call smartinput#define_rule({
"   "     \ 'at': '\%#\S', 'char': ']', 'input': ']' })
"   "   call smartinput#define_rule({
"   "     \ 'at': '\%#\S', 'char': '{', 'input': '{' })
"   "   call smartinput#define_rule({
"   "     \ 'at': '\%#\S', 'char': '}', 'input': '}' })
"   "
"   "   "" C++でstruct, class, enum+{の入力後に;を追記
"   "   call smartinput#define_rule({
"   "     \   'at'       : '\%(\<struct\>\|\<class\>\|\<enum\>\)\s*\w\+.*\%#',
"   "     \   'char'     : '{',
"   "     \   'input'    : '{};<Left><Left>',
"   "     \   'filetype' : ['cpp'],
"   "     \   })
"   "   call smartinput#map_to_trigger('i', ':', ':', ':')
"   "   " call smartinput#define_rule({
"   "   "             \   'at'       : ':\%#',
"   "   "             \   'char'     : ':',
"   "   "             \   'input'    : '<BS>::',
"   "   "             \   'filetype' : ['cpp'],
"   "   "             \   })
"   "   "" s:: -> std::, b:: -> boost::
"   "   "" boost:: の補完
"   "   call smartinput#define_rule({
"   "     \   'at'       : '\<b:\%#',
"   "     \   'char'     : ':',
"   "     \   'input'    : '<BS>oost::',
"   "     \   'filetype' : ['cpp'],
"   "     \   })
"   "   " std:: の補完
"   "   call smartinput#define_rule({
"   "     \   'at'       : '\<s:\%#',
"   "     \   'char'     : ':',
"   "     \   'input'    : '<BS>td::',
"   "     \   'filetype' : ['cpp'],
"   "     \   })
"   "   " detail:: の補完
"   "   call smartinput#define_rule({
"   "     \   'at'       : '\%(\s\|::\)d:\%#',
"   "     \   'char'     : ':',
"   "     \   'input'    : '<BS>etail::',
"   "     \   'filetype' : ['cpp'],
"   "     \   })
" endif
" 
" 
" if s:Neobundled('unite.vim')
"     let g:unite_source_history_yank_enable=1
"     nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
"     nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" endif
" 
" if s:Neobundled('neomru.vim')
"     let g:neomru#time_format = "[%Y%m%dT%H%M] "
"     let g:unite_source_file_mru_limit = 200
"     nnoremap <silent> ,ur :<C-u>Unite file_mru<CR>
" endif
" 
"   augroup cpp-path
"       autocmd!
"       autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/usr/lib/c++/v1
"   augroup END
" 
" if s:Neobundled('clang_complete')
"     let g:clang_periodic_quickfix = 1
"     let g:clang_complete_copen = 1
"     let g:clang_use_library = 1
" 
"     " this need to be updated on llvm update
"     let g:clang_library_path = '/usr/lib/llvm-3.4/lib'
"     " specify compiler options
"     let g:clang_user_options = '-std=c++11 -stdlib=libc++'
" endif
" 
" if s:Neobundled('vim-submode')
"     "" ウィンドウサイズ変更
"     call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
"     call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
"     call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
"     call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
"     call submode#map('winsize', 'n', '', '>', '<C-w>>')
"     call submode#map('winsize', 'n', '', '<', '<C-w><')
"     call submode#map('winsize', 'n', '', '+', '<C-w>-')
"     call submode#map('winsize', 'n', '', '-', '<C-w>+')
"     "" タブページ切り替え
"     call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
"     call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
"     call submode#map('changetab', 'n', '', 't', 'gt')
"     call submode#map('changetab', 'n', '', 'T', 'gT')
"     "" undo/redoを巡る
"     call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
"     call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
"     call submode#map('undo/redo', 'n', '', '-', 'g-')
"     call submode#map('undo/redo', 'n', '', '+', 'g+')
"     "" Quickfix
"     call submode#enter_with('quickfix', 'n', '', '<Leader>q', '<Nop>')
"     call submode#map('quickfix', 'n', '', 'k', ':cprevious<CR>')
"     call submode#map('quickfix', 'n', '', 'j', ':cnext<CR>')
" endif
" 
" if s:Neobundled('vim-indent-guides')
"     "" vim-indent-guides'
"     " let g:indent_guides_enable_on_vim_startup = 1
"     let g:indent_guides_start_level = 2 " start indent column
"     let g:indent_guides_auto_colors = 0
"     "" 奇数インデントのカラー
"     autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
"     " "" 偶数インデントのカラー
"     autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=yellow " darkgray
"     let g:indent_guides_color_change_percent  =  30 " width of changing highlight color
"     let g:indent_guides_guide_size = 1 " indent guide size
" endif
" 
" 
" if s:Neobundled('vim-quickrun')
"     let g:quickrun_config = {} " initialization
"     "" default option
"     let g:quickrun_config._ = {
"     \ 'runner' : 'vimproc',
"     \ 'runner/vimproc/updatetime': 10,
"     \ 'split': '',
"     \ }
" 
"     let g:quickrun_config.fortran = {'cmdopt': '-Wall -O3 -static'}
"     let g:quickrun_config.cpp = {'cmdopt': '-Wall'}
"     let g:quickrun_config.c = {'cmdopt': '-Wall -std=gnu11'}
" 
"     set splitbelow
"     " set splitright
" endif
" 
" 
" " if s:Neobundled('vim-easymotion')
" "     let g:EasyMotion_do_mapping = 0
" "     nmap s <Plug>(easymotion-s2)
" "     xmap s <Plug>(easymotion-s2)
" "     omap z <Plug>(easymotion-s2)
" "     " Turn on case sensitive feature
" "     let g:EasyMotion_smartcase = 1
" "     " `JK` Motions: Extend line motions
" "     map <Leader>j <Plug>(easymotion-j)
" "     map <Leader>k <Plug>(easymotion-k)
" "     " keep cursor column with `JK` motions
" "     let g:EasyMotion_startofline = 0
" "     map f <Plug>(easymotion-fl)
" "     " =======================================
" "     " General Configuration
" "     " =======================================
" "     let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'
" "     " Show target key with upper case to improve readability
" "     let g:EasyMotion_use_upper = 1
" "     " Jump to first match with enter & space
" "     let g:EasyMotion_enter_jump_first = 1
" "     let g:EasyMotion_space_jump_first = 1
" "
" "     " =======================================
" "     " Search Motions
" "     " =======================================
" "     " Extend search motions with vital-over command line interface
" "     " Incremental highlight of all the matches
" "     " Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
" "     " `<Tab>` & `<S-Tab>` to scroll up/down a page with next match
" "     " :h easymotion-command-line
" "     nmap g/ <Plug>(easymotion-sn)
" "     xmap g/ <Plug>(easymotion-sn)
" "     omap g/ <Plug>(easymotion-tn)
" "
" "     map t <Plug>(easymotion-tl)
" "     map F <Plug>(easymotion-Fl)
" "     map T <Plug>(easymotion-Tl)
" " endif
" 
" " if s:Neobundled('vimfiler')
" "   """ vimfiler
" "   "" autocmd VimEnter * VimFiler -split -simple -winwidth=25 -no-quit " look like
" "   "" IDE explore on startup
" "   let g:vimfiler_as_default_explorer  = 1
" "   let g:vimfiler_safe_mode_by_default = 0
" " endif
" 
" if s:Neobundled('ctrlp.vim')
"   let g:ctrlp_extensions = ['funky']
" endif
" 
" if s:Neobundled('ctrlp-funky')
"   let g:ctrlp_funky_matchtype = 'path'
" endif
" 
" "" vim-easy-align
" vmap <Enter> <Plug>(EasyAlign)
" xmap ga <Plug>(EasyAlign)
" nmap ga <Plug>(EasyAlign)

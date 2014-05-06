set number	" show line number
set guifont=migu_1m:h10	"font
"set guifont=ipagothic:h12	"font
"set guifont=consolas:h12	"font
set textwidth=0
set formatoptions=q
nnoremap <silent> ,F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

let g:neocomplcache_enable_at_startup = 1

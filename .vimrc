" mikeris vim config

" -- basic config options --
set fileencoding=utf-8
set gfn=GohuFont\ 10
set encoding=utf-8
set ttimeoutlen=50
set relativenumber
set cursorline
set lazyredraw
set expandtab
set hlsearch
set wildmenu
set undofile
set mouse=a
set sts=4
set ts=4
set sw=4
set ic
set nu

" -- plugins, managed by vim-plug --
call plug#begin('~/.config/nvim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/denite.nvim'
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
Plug 'KabbAmine/vCoolor.vim'
Plug 'ap/vim-css-color'
Plug 'justinmk/vim-sneak'

" Plug 'Indent-Guides'
" Plug 'metakirby5/codi.vim'
" Plug 'zchee/deoplete-jedi'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'FuzzyFinder'
" Plug 'davidhalter/jedi-vim'
" Plug 'DonnieWest/VimStudio'
" Plug 'mattn/emmet-vim'
" Plug 'Yggdroot/indentLine'
" Plug 'w0rp/ale'
" Plug 'jplaut/vim-arduino-ino'
" Plug 'pyflakes.vim'
" Plug 'davidhalter/jedi-vim'
" Plug 'jaxbot/browserlink.vim'
" Plug 'Yggdroot/indentLine'
" Plug 'vim-scripts/taglist.vim'

call plug#end()

" -- deoplete --
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" -- airline --
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_section_warning = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline_left_sep=''
let g:airline_right_sep=''

" -- tagbar --
let g:tagbar_left=1

" -- sneak --
" autocmd ColorScheme * hi Sneak guifg=23 guibg=white ctermfg=23 ctermbg=white cterm=bold
map , <Plug>Sneak_;
map ; <Plug>Sneak_,

" -- denite --
noremap \b :Denite buffer<CR>
noremap \f :Denite file_rec<CR>
noremap \t :Denite tab<CR>
call denite#custom#map(
	      \ 'insert',
	      \ '<C-k>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
	      \)
call denite#custom#map(
	      \ 'insert',
	      \ '<C-j>',
	      \ '<denite:move_to_next_line>',
	      \ 'noremap'
	      \)

" -- supertab --
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" -- misc config --
set guioptions-=T
set guioptions-=m
set dir=~/.vim/swapfiles
cnoreabbrev c64 !~/Development/c64/kickassend.sh %
cnoreabbrev vice !~/Development/c64/kickassvice.sh %
cnoreabbrev sudow !sudo tee %
cnoreabbrev W w
cnoreabbrev Q q
" syntax on
set laststatus=2

" -- tab/window navigation --
noremap <A-k> <C-w>k 
noremap <A-j> <C-w>j 
noremap <A-h> gT
noremap <A-l> gt

" -- writing mode --
function! Code()
    setlocal nospell
    set cursorline
    set nolinebreak
    unmap j
    unmap k
endfunction

function! Text()
    setlocal spell spelllang=en_us
    set nocursorline
    set linebreak
    map j gj 
    map k gk
endfunction

command Text call Text()
command Code call Code()

" -- theme stuff --
colorscheme desert-warm-256
hi SpellBad ctermfg=NONE ctermbg=100
hi ErrorMsg ctermfg=NONE ctermbg=88
hi WarningMsg ctermfg=NONE ctermfg=242 ctermbg=238
hi SignColumn ctermbg=236
hi ColumnLine ctermbg=236

" -- neomake --
let g:neomake_error_sign = { 'text': '>>', 'texthl': 'ErrorMsg' } 
let g:neomake_warning_sign = { 'text': '>>', 'texthl': 'WarningMsg' } 
let g:neomake_python_enabled_makers = ['pyflakes', 'pylint']
let g:neomake_javascript_makers = ['eslint']
let g:neomake_javascript_eslint_maker = {
    \ 'exe': 'eslint',
    \ 'args': ['-f', 'compact', '--no-eslintrc' ],
    \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
    \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#'
    \ }

let g:neomake_verbose = 0
autocmd! BufWrite * Neomake

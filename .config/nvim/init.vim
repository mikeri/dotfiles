filetype off                   " required!
set encoding=utf-8
set fileencoding=utf-8
set hlsearch
set ic
" set rtp+=~/.vim/bundle/vundle/
set nu
set ts=4
set sw=4
set sts=4
set expandtab
set gfn=GohuFont\ 10
set ttimeoutlen=50
set relativenumber
set wildmenu
set cursorline
set lazyredraw
set mouse=a
" call vundle#rc()
" Vundle stuff:
call plug#begin('~/.config/nvim/bundle')
" Plug 'gmarik/vundle'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'jaxbot/browserlink.vim'
Plug 'taglist.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
" Plug 'jplaut/vim-arduino-ino'
" Plug 'pyflakes.vim'
" Plug 'davidhalter/jedi-vim'
Plug 'supertab'
Plug 'benekastah/neomake'
" Plug 'DonnieWest/VimStudio'
" Plug 'mattn/emmet-vim'
" Plug 'Yggdroot/indentLine'
" Plug 'ap/vim-css-color'
" Plug 'Indent-Guides'
" Plug 'FuzzyFinder'

" Airline
call plug#end()
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline_section_warning = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline_left_sep=''
let g:airline_right_sep=''
filetype plugin indent on     " required!
autocmd FileType python setlocal completeopt+=preview
let g:jedi#popup_on_dot=1
let g:pymode_folding=1
let g:jedi#show_call_signatures=1
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
set guioptions-=T
set guioptions-=m
set dir=~/.vim/swapfiles
cnoreabbrev c64 !~/Development/c64/kickassend.sh %
cnoreabbrev vice !~/Development/c64/kickassvice.sh %
cnoreabbrev W w
cnoreabbrev Q q
colorscheme desert-warm-256
syntax on
autocmd! BufWrite * Neomake
set laststatus=2
" Fix error highlight
hi SpellBad ctermfg=NONE ctermbg=100
hi ErrorMsg ctermfg=NONE ctermbg=88
hi WarningMsg ctermfg=NONE ctermfg=242 ctermbg=238
hi SignColumn ctermbg=236
let g:neomake_error_sign = { 'text': '>>', 'texthl': 'ErrorMsg' } 
let g:neomake_warning_sign = { 'text': '>>', 'texthl': 'WarningMsg' } 
let g:neomake_python_enabled_makers = ['pyflakes', 'pylint']
let g:neomake_verbose = 0

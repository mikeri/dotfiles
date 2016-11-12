filetype off                   " required!
set t_ut= 
set hlsearch
set ic
set rtp+=~/.vim/bundle/vundle/
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
call vundle#rc()
" Vundle stuff:
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'taglist.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'bling/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'Lokaltog/vim-easymotion'
" Bundle 'pyflakes.vim'
Bundle 'davidhalter/jedi-vim'
Bundle 'supertab'
Bundle 'syntastic'
Bundle 'mattn/emmet-vim'
" Bundle 'Yggdroot/indentLine'
" Bundle 'ap/vim-css-color'
" Bundle 'Indent-Guides'
" Bundle 'FuzzyFinder'
" Airline
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
" autocmd FileType python setlocal completeopt-=preview
let g:jedi#popup_on_dot=0
let g:pymode_folding=0
let g:jedi#show_call_signatures=0
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
set laststatus=2
" Fix error highlight
hi SpellBad ctermfg=NONE ctermbg=88

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

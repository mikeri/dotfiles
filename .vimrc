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

nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" -- plugins, managed by vim-plug --
call plug#begin('~/.config/nvim/bundle')

Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'ap/vim-css-color'

call plug#end()

" -- fzf --
noremap <leader>f :Files<CR>
noremap <leader>b :Buffers<CR>

" -- supertab --
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" -- misc config --
set guioptions-=T
set guioptions-=m
set dir=~/.vim/swapfiles//
set undodir=~/.vim/undo//
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

" -- commentary --
setlocal commentstring=#\ %s

" -- airline --
let g:airline_theme='powerlineish'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_warning = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline_left_sep=''
let g:airline_right_sep=''


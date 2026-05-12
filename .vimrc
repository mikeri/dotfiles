" minimal pluginless vim config for servers

" -- basic config options --
set ttimeoutlen=50
set relativenumber
set nocompatible
set cursorline
set lazyredraw
set ignorecase
set laststatus=2
set expandtab
set hlsearch
set wildmenu
set undofile
set number
set mouse=a
set sts=4
set ts=4
set sw=4

nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
syntax on

" -- dirs --
let s:vimdir = expand('~/.config/vim')
let s:undodir = s:vimdir . '/undo'
let s:swapdir = s:vimdir . '/swap'

if !isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif

if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, 'p')
endif

let &undodir = s:undodir
let &directory = s:swapdir

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

" -- appearance --
colorscheme desert
hi LineNr ctermfg=darkgrey
hi StatusLine ctermfg=45 ctermbg=238
hi normal ctermbg=235
hi LineNr ctermbg=236
hi CursorLineNr ctermbg=238 ctermfg=248
hi CursorLine ctermbg=236
hi EndOfBuffer ctermfg=238 ctermbg=234

" -- status line --
set statusline=
set statusline+=%#CursorColumn#
set statusline+=\ %f\ 
set statusline+=%#StatusLine#
set statusline+=%m\ 
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

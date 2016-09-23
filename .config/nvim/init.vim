" mikeris neovim config

" -- core config options --
filetype off
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

" -- plugins, managed by vim-plug --
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
Plug 'Shougo/unite.vim'
" Plug 'jplaut/vim-arduino-ino'
"" Plug 'pyflakes.vim'
" Plug 'davidhalter/jedi-vim'
Plug 'supertab'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
" Plug 'davidhalter/jedi-vim'
" Plug 'DonnieWest/VimStudio'
" Plug 'mattn/emmet-vim'
" Plug 'Yggdroot/indentLine'
" Plug 'ap/vim-css-color'
" Plug 'Indent-Guides'
" Plug 'FuzzyFinder'
call plug#end()
filetype plugin indent on     " required!

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

"autocmd FileType python setlocal completeopt+=preview
"let g:jedi#popup_on_dot=1
"let g:pymode_folding=1
"let g:jedi#show_call_signatures=1
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
set guioptions-=T
set guioptions-=m
set dir=~/.vim/swapfiles
cnoreabbrev c64 !~/Development/c64/kickassend.sh %
cnoreabbrev vice !~/Development/c64/kickassvice.sh %
cnoreabbrev W w
cnoreabbrev Q q
noremap \b :Unite buffer<CR>
noremap \f :Unite file<CR>
colorscheme desert-warm-256
syntax on
autocmd! BufWrite * Neomake
set laststatus=2

" -- color theme tweaks --
hi SpellBad ctermfg=NONE ctermbg=100
hi ErrorMsg ctermfg=NONE ctermbg=88
hi WarningMsg ctermfg=NONE ctermfg=242 ctermbg=238
hi SignColumn ctermbg=236

" -- neomake --
let g:neomake_error_sign = { 'text': '>>', 'texthl': 'ErrorMsg' } 
let g:neomake_warning_sign = { 'text': '>>', 'texthl': 'WarningMsg' } 
let g:neomake_python_enabled_makers = ['pyflakes', 'pylint']
let g:neomake_verbose = 0

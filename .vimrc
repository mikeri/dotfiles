filetype off                   " required!
set hlsearch
set ic
set rtp+=~/.vim/bundle/vundle/
set nu
set ts=2
set sw=2
set gfn=GohuFont\ 10
set ttimeoutlen=50
set relativenumber
" highlight LineNr guibg=#222
call vundle#rc()
colorscheme desert-warm-256
 let g:airline_theme='powerlineish'
 let g:airline#extensions#tabline#enabled=1
 let g:airline#extensions#tabline#buffer_nr_show=1
 let g:airline_section_warning = ''
 let g:airline#extensions#tabline#formatter = 'unique_tail'
" hi CursorLine cterm=none ctermbg=darkgrey
set cursorline
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'taglist.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'bling/vim-bufferline'
Bundle 'bling/vim-airline'
" Bundle 'itchyny/lightline.vim'
Bundle 'Lokaltog/vim-easymotion'
" Bundle 'skammer/vim-css-color'
" Bundle 'Indent-Guides'
" vim-scripts repos
" Bundle 'FuzzyFinder'
" non github repos
" ...
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" nnoremap <C-Left> :tabprevious<CR>
" nnoremap <C-Right> :tabnext<CR>
set guioptions-=T
set guioptions-=m
set dir=~/.vim/swapfiles
cnoreabbrev c64 !~/Development/c64/kickassend.sh %
cnoreabbrev vice !~/Development/c64/kickassvice.sh %
cnoreabbrev :W :w
cnoreabbrev :Q :q
" Airline
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline_left_sep=''
let g:airline_right_sep=''

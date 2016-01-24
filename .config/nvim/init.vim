filetype off                   " required!
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
Plug 'jaxbot/browserlink.vim'
Plug 'taglist.vim'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'bling/vim-airline'
Plug 'Lokaltog/vim-easymotion'
Plug 'jplaut/vim-arduino-ino'
" Plug 'pyflakes.vim'
Plug 'davidhalter/jedi-vim'
Plug 'supertab'
Plug 'benekastah/neomake'
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
hi WarningMsg ctermfg=NONE ctermbg=214
hi SignColumn ctermbg=236
let g:neomake_error_sign = { 'text': '>>', 'texthl': 'ErrorMsg' } 
let g:neomake_warning_sign = { 'text': '>>', 'texthl': 'WarningMsg' } 
let g:neomake_python_enabled_makers = ['pyflakes', 'pylint']
let g:neomake_verbose = 0

" Compatible with ranger 1.4.2 through 1.7.*
"
" Add ranger as a file chooser in vim
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

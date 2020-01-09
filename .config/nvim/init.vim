" mikeris neovim config

" -- basic config options --
set guicursor=n-v-c-sm:block-blinkon175-blinkoff150,i-ci-ve:ver25-blinkon175-blinkoff150,r-cr-o:hor20
set fileencoding=utf-8
set gfn=GohuFont\ 10
set encoding=utf-8
set ttimeoutlen=50
set signcolumn=yes
set relativenumber
set cursorline
set lazyredraw
set expandtab
set showmatch
set hlsearch
set wildmenu
set undofile
set hidden
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
Plug 'mbbill/undotree'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'KabbAmine/vCoolor.vim'
Plug 'ap/vim-css-color'
Plug 'justinmk/vim-sneak'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'msrose/vim-perpetuloc'

" Plug 'vim-python/python-syntax'
" Plug 'chrisbra/csv.vim'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Plug 'ervandew/supertab'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/denite.nvim'
" Plug 'jaxbot/browserlink.vim'
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" Plug 'davidhalter/jedi-vim'
" Plug 'zchee/deoplete-jedi'
" Plug 'benekastah/neomake'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'KabbAmine/zeavim.vim'
" Plug 'metakirby5/codi.vim'
" Plug 'Indent-Guides'
" Plug 'FuzzyFinder'
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

" -- vim-perpetuloc --
nnoremap <C-k> :Lprevious<CR>
nnoremap <C-j> :Lnext<CR>

" -- deoplete-jedi --
" let g:deoplete#sources#jedi#show_docstring = 1

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

" -- tagbar --
let g:tagbar_left=1
noremap <Leader>t :TagbarOpenAutoClose<CR>

" -- sneak --
autocmd ColorScheme * hi Sneak guifg=23 guibg=white ctermfg=23 ctermbg=white cterm=bold
map , <Plug>Sneak_;
map ; <Plug>Sneak_,

" -- undoTree --
function! UndoToggleAndFocus()
    UndotreeToggle
    UndotreeFocus
endfunction
command UndoToggleAndFocus call UndoToggleAndFocus()
noremap U :UndoToggleAndFocus<CR>

" -- fzf --
noremap \f :Files<CR>
noremap \b :Buffers<CR>
autocmd FileType fzf set norelativenumber 
autocmd FileType fzf set nonumber 
autocmd FileType fzf set signcolumn=no 

" -- denite --
" noremap \b :Denite buffer<CR>
" noremap \f :Denite file_rec<CR>
" noremap \g :Denite register<CR>
" call denite#custom#map(
" 	      \ 'insert',
" 	      \ '<C-k>',
" 	      \ '<denite:move_to_previous_line>',
" 	      \ 'noremap'
" 	      \)
" call denite#custom#map(
" 	      \ 'insert',
" 	      \ '<C-j>',
" 	      \ '<denite:move_to_next_line>',
" 	      \ 'noremap'
	      " \)

" -- supertab --
" let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" -- misc config --
set guioptions-=T
set guioptions-=m
set dir=~/.vim/swapfiles//
set undodir=~/.vim/undo//
cnoreabbrev c64 !~/Development/code/c64/kickassend.sh %
cnoreabbrev vice !~/Development/code/c64/kickassvice.sh %
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
hi SpellBad   ctermfg=NONE ctermbg=100
hi SpellCap   ctermfg=NONE ctermbg=160
hi ErrorMsg   ctermfg=NONE ctermbg=88
hi ErrorCol   ctermfg=196  ctermbg=236 cterm=bold
hi Error      ctermfg=210  ctermbg=88
hi WarningMsg ctermfg=226  ctermbg=236
hi WarningCol ctermfg=100  ctermbg=236
hi Todo       ctermfg=226  ctermbg=94
hi SignColumn ctermbg=236
hi ColumnLine ctermbg=236

" -- neomake --
" let g:neomake_error_sign = { 'text': '>>', 'texthl': 'ErrorMsg' } 
" let g:neomake_warning_sign = { 'text': '>>', 'texthl': 'WarningMsg' } 
" let g:neomake_highlight_columns = 0
" let g:neomake_python_enabled_makers = ['pylint']
" let g:neomake_python_pylint_args = neomake#makers#ft#python#pylint().args + ['--extension-pkg-whitelist=wx']
" let g:neomake_javascript_makers = ['eslint']
" let g:neomake_javascript_eslint_maker = {
"     \ 'exe': 'eslint',
"     \ 'args': ['-f', 'compact', '--no-ignore', '--no-eslintrc' ],
"     \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
"     \   '%W%f: line %l\, col %c\, Warning - %m,%-G,%-G%*\d problems%#'
"     \ }
" let g:neomake_verbose = 0
" call neomake#configure#automake('nw', 500)

" " -- lsp client --
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ 'javascript': ['~/.local/bin/javascript-typescript-stdio'],
"     \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"     \ 'python': ['~/.local/bin/pyls'],
"     \ 'sh': ['~/.local/bin/bash-language-server', 'start'],
"     \ 'c': ['clangd-7'],
"     \ 'json': ['~/.local/bin/json-languageserver'],
"     \ }
" let g:LanguageClient_diagnosticsDisplay = {
"     \ 1: {
"     \     "name": "Error",
"     \     "texthl": "ErrorMsg",
"     \     "signText": ">>",
"     \     "signTexthl": "ErrorCol",
"     \ },
"     \ 2: {
"     \     "name": "Warning",
"     \     "texthl": "None",
"     \     "signText": ">>",
"     \     "signTexthl": "WarningCol",
"     \ }}
" nnoremap <silent> <Leader>k :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> <Leader>d :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <Leader>r :call LanguageClient#textDocument_rename()<CR>
" nnoremap <silent> <Leader>j :call LanguageClient#textDocument_formatting()<CR>

" -- coc --
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>e <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

hi CocErrorFloat   ctermfg=NONE ctermbg=88
hi CocErrorSign    ctermfg=196  ctermbg=236 cterm=bold
hi CocWarningFloat ctermfg=226  ctermbg=236
hi CocWarningSign  ctermfg=100  ctermbg=236

" -- commentary --
setlocal commentstring=#\ %s

" -- semshi --
function SemshiHighlights()
    hi semshiLocal           ctermfg=216 guifg=#ff875f
    hi semshiGlobal          ctermfg=218 guifg=#ffaf40
    hi semshiImported        ctermfg=159 guifg=#ffaf40 cterm=none
    hi semshiParameter       ctermfg=117 guifg=#5fafff
    hi semshiParameterUnused ctermfg=75  guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree            ctermfg=219 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=223 guifg=#ff7fff
    hi semshiAttribute       ctermfg=86  guifg=#40cfaf
    hi semshiSelf            ctermfg=249 guifg=#b2b2b2
    hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=32 guibg=#47a0af
endfunction
call SemshiHighlights()
autocmd FileType python call SemshiHighlights()
let g:semshi#error_sign=v:false

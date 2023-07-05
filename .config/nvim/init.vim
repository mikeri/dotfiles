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
set noautoread
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
Plug 'junegunn/vim-peekaboo'
Plug 'KabbAmine/vCoolor.vim'
Plug 'ap/vim-css-color'
Plug 'peterhoeg/vim-qml'
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'dominikduda/vim_current_word'
Plug 'ervandew/supertab'
Plug 'phaazon/hop.nvim'
Plug 'zah/nim.vim'
Plug 'folke/trouble.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'msrose/vim-perpetuloc'
" Plug 'ggandor/lightspeed.nvim'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Plug 'psf/black'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'justinmk/vim-sneak'
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'vim-python/python-syntax'
" Plug 'chrisbra/csv.vim'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
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

" -- telescope --
lua << EOF
local actions = require "telescope.actions"
require('telescope').setup{
  defaults = {
    layout_strategy = "vertical", 
    layout_config = {
      horizontal = {
        width = 0.95,
        preview_cutoff = 60
      },
      vertical = {
        width = 0.9,
        preview_cutoff = 20
      }
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      }
    }
  },
  pickers = {
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
require('telescope').load_extension('fzf')
EOF
noremap \f :Telescope find_files<CR>
noremap \b :Telescope buffers<CR>
noremap \r :Telescope live_grep<CR>


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

" -- black --
autocmd FileType python nnoremap <leader>j :Black<CR>

" -- vim-perpetuloc --
nnoremap <C-k> :Lprevious<CR>
nnoremap <C-j> :Lnext<CR>

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
function! TagbarFocusToggleFn()
    if tagbar#IsOpen()
        TagbarClose
    else
        TagbarOpenAutoClose
    endif
endfunction

command! TagbarFocusToggle call TagbarFocusToggleFn()
let g:tagbar_left=1
noremap <Leader>t :TagbarFocusToggle<CR>

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

" -- supertab --
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" -- misc config --
set guioptions-=T
set guioptions-=m
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
highlight LspDiagnosticsDefaultError ctermfg=196
highlight LspDiagnosticsDefaultWarning ctermfg=184
highlight LspDiagnosticsDefaultInformation ctermfg=247
highlight LspDiagnosticsDefaultHint ctermfg=156

highlight TelescopeNormal ctermfg=250
highlight TelescopeBorder ctermfg=244
highlight TelescopePromptTitle ctermfg=255
highlight TelescopeResultsTitle ctermfg=255
highlight TelescopePreviewTitle ctermfg=255
highlight TelescopeSelection ctermbg=240 ctermfg=226 cterm=bold
highlight TelescopePreviewMessageFillchar ctermfg=240 

" -- commentary --
setlocal commentstring=#\ %s

" -- lspconfig --
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'html', 'cssls', 'eslint', 'gdscript', 'jsonls', 'nimls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp['pyright'].setup {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
        },
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off'
                }
            }
        }
    }
EOF

" -- treesitter --
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" -- Current Word --
hi CurrentWordTwins ctermfg=255 ctermbg=32 cterm=bold

" -- Hop --
lua require'hop'.setup()
nnoremap s :HopChar2<CR>

" -- trouble --
lua << EOF
  require("trouble").setup {
    icons=false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    auto_preview = false,
    mode = "document_diagnostics",
    signs = {
        -- icons / text used for a diagnostic
        error = "E",
        warning = "W",
        hint = "H",
        information = "I"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  }
EOF
nnoremap T <cmd>TroubleToggle<cr>

" -- vcoolor --
let g:vcoolor_lowercase = 1

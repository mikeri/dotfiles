-- mikeris neovim config

-- Basic config options
vim.opt.guicursor = "n-v-c-sm:block-blinkon175-blinkoff150,i-ci-ve:ver25-blinkon175-blinkoff150,r-cr-o:hor20"
vim.opt.fileencoding = "utf-8"
vim.opt.guifont = "GohuFont 10"
vim.opt.termguicolors = false
vim.opt.encoding = "utf-8"
vim.opt.ttimeoutlen = 50
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.autoread = false
vim.opt.expandtab = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.wildmenu = true
vim.opt.undofile = true
vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.laststatus = 2

-- Plugin-specific settings that need to be set early
vim.g.tagbar_left = 1

-- Set leader key
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
    vim.system({ 'make' }, { cwd = ev.data.path }):wait()
  end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

vim.pack.add({
  "https://github.com/tpope/vim-fugitive",
  
  "https://github.com/majutsushi/tagbar",
  {
    src = "https://github.com/mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  
  {
    src = "https://github.com/vim-airline/vim-airline",
    dependencies = {"vim-airline/vim-airline-themes"},
  },
  "https://github.com/vim-airline/vim-airline-themes",
  "https://github.com/junegunn/vim-peekaboo",
  
  "https://github.com/KabbAmine/vCoolor.vim",
  "https://github.com/ap/vim-css-color",
  
  "https://github.com/peterhoeg/vim-qml",
  "https://github.com/zah/nim.vim",
  
  {
    src = "https://github.com/neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
  },
  "https://github.com/folke/lsp-colors.nvim",
  
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
      ensure_installed = {},
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    },
  },
  
  "https://github.com/dominikduda/vim_current_word",
  
  {
    src = "https://github.com/ervandew/supertab",
    event = "InsertEnter",
  },
  
  "https://github.com/folke/trouble.nvim",
  
  {
    src = "https://github.com/iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = {"markdown"},
  },
  "https://github.com/nvim-lua/plenary.nvim",
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/sbdchd/neoformat",
  
  "https://github.com/nvim-neotest/nvim-nio",
  {
    src = "https://github.com/mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      {"<F5>", function() require('dap').continue() end, desc = "Debug: Continue"},
      {"<F6>", function() require('dap').step_over() end, desc = "Debug: Step Over"},
      {"<F7>", function() require('dap').step_into() end, desc = "Debug: Step Into"},
      {"<F8>", function() require('dap').step_out() end, desc = "Debug: Step Out"},
      {"<Leader>p", function() require('dap').toggle_breakpoint() end, desc = "Toggle Breakpoint"},
    },
  },
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/mfussenegger/nvim-dap-python",
  
  {
    src = "https://github.com/rstacruz/sparkup",
    dir = vim.fn.stdpath("data") .. "/lazy/sparkup/vim/",
  },
})

-- nvim-dap configuration
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("dapui").setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 }
      },
      position = "bottom",
      size = 8
    }
  },
  controls = {
    icons = {
      disconnect = "╳",
      pause = "⏸",
      play = "⏵",
      run_last = "⏴",
      step_back = "↩",
      step_into = "↴",
      step_out = "↱",
      step_over = "↦",
      terminate = "⏹"
    }
  },
  icons = {
    collapsed = "↓",
    current_frame = "⏘",
    expanded = "↳"
  }
})

vim.keymap.set('n', '<F10>', function() require('dapui').open() end)
vim.keymap.set('n', '<F11>', function() require('dapui').close() end)

-- telescope
local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        width = 0.95,
        preview_cutoff = 60,
      },
      vertical = {
        width = 0.9,
        preview_cutoff = 20,
      },
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {},
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

telescope.load_extension("fzf")

vim.keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<Leader>r", "<cmd>Telescope live_grep<CR>")

-- airline
vim.g.airline_theme = 'powerlineish'
vim.g['airline#extensions#coc#enabled'] = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
vim.g.airline_section_warning = ''
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_alt_sep = ''
vim.g.airline_left_sep = ''
vim.g.airline_right_sep = ''

-- tagbar
local function tagbar_focus_toggle()
  if vim.fn['tagbar#IsOpen']() == 1 then
    vim.cmd('TagbarClose')
  else
    vim.cmd('TagbarOpenAutoClose')
  end
end

vim.api.nvim_create_user_command('TagbarFocusToggle', tagbar_focus_toggle, {})
vim.keymap.set('n', '<Leader>t', tagbar_focus_toggle, { noremap = true, desc = "Toggle Tagbar" })

-- sneak (if installed)
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  command = 'hi Sneak guifg=23 guibg=white ctermfg=23 ctermbg=white cterm=bold'
})
vim.keymap.set('', ',', '<Plug>Sneak_;', { silent = true })
vim.keymap.set('', ';', '<Plug>Sneak_,', { silent = true })

-- undotree
local function undo_toggle_and_focus()
  vim.cmd('UndotreeToggle')
  vim.cmd('UndotreeFocus')
end

vim.api.nvim_create_user_command('UndoToggleAndFocus', undo_toggle_and_focus, {})
vim.keymap.set('n', 'U', ':UndoToggleAndFocus<CR>', { noremap = true })

-- supertab
vim.g.SuperTabDefaultCompletionType = "<c-x><c-o>"

-- misc config
vim.cmd.cnoreabbrev('c64', '!~/Development/code/c64/kickassend.sh %')
vim.cmd.cnoreabbrev('vice', '!~/Development/code/c64/kickassvice.sh %')
vim.cmd.cnoreabbrev('sudow', '!sudo tee %')
vim.cmd.cnoreabbrev('W', 'w')
vim.cmd.cnoreabbrev('Q', 'q')

-- tab/window navigation
vim.keymap.set('n', '<A-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<A-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<A-h>', 'gT', { noremap = true })
vim.keymap.set('n', '<A-l>', 'gt', { noremap = true })

-- writing mode
local function code_mode()
  vim.opt_local.spell = false
  vim.opt.cursorline = true
  vim.opt.linebreak = false
  pcall(vim.keymap.del, 'n', 'j')
  pcall(vim.keymap.del, 'n', 'k')
end

local function text_mode()
  vim.opt_local.spell = true
  vim.opt_local.spelllang = 'en_us'
  vim.opt.cursorline = false
  vim.opt.linebreak = true
  vim.keymap.set('', 'j', 'gj')
  vim.keymap.set('', 'k', 'gk')
end

vim.api.nvim_create_user_command('Text', text_mode, {})
vim.api.nvim_create_user_command('Code', code_mode, {})

-- theme stuff
vim.cmd('colorscheme desert-warm-256')
vim.cmd('hi SpellBad   ctermfg=NONE ctermbg=100')
vim.cmd('hi SpellCap   ctermfg=NONE ctermbg=160')
vim.cmd('hi ErrorMsg   ctermfg=NONE ctermbg=88')
vim.cmd('hi ErrorCol   ctermfg=196  ctermbg=236 cterm=bold')
vim.cmd('hi Error      ctermfg=210  ctermbg=88')
vim.cmd('hi WarningMsg ctermfg=226  ctermbg=236')
vim.cmd('hi WarningCol ctermfg=100  ctermbg=236')
vim.cmd('hi Todo       ctermfg=226  ctermbg=94')
vim.cmd('hi SignColumn ctermbg=236')
vim.cmd('hi ColumnLine ctermbg=236')
vim.cmd('highlight LspDiagnosticsDefaultError ctermfg=196')
vim.cmd('highlight LspDiagnosticsDefaultWarning ctermfg=184')
vim.cmd('highlight LspDiagnosticsDefaultInformation ctermfg=247')
vim.cmd('highlight LspDiagnosticsDefaultHint ctermfg=156')
vim.cmd('highlight TelescopeNormal ctermfg=250')
vim.cmd('highlight TelescopeBorder ctermfg=244')
vim.cmd('highlight TelescopePromptTitle ctermfg=255')
vim.cmd('highlight TelescopeResultsTitle ctermfg=255')
vim.cmd('highlight TelescopePreviewTitle ctermfg=255')
vim.cmd('highlight TelescopeSelection ctermbg=240 ctermfg=226 cterm=bold')
vim.cmd('highlight TelescopePreviewMessageFillchar ctermfg=240')
vim.cmd('hi DapUIVariable ctermfg=120')
vim.cmd('hi DapUIScope ctermfg=167 cterm=bold')
vim.cmd('hi DapUIType ctermfg=222 cterm=bold')
vim.cmd('hi link DapUIValue Normal')
vim.cmd('hi DapUIModifiedValue ctermfg=51 gui=bold')
vim.cmd('hi DapUIDecoration ctermfg=243')
vim.cmd('hi DapUIThread ctermfg=155')
vim.cmd('hi DapUIStoppedThread ctermfg=51')
vim.cmd('hi link DapUIFrameName Normal')
vim.cmd('hi DapUISource ctermfg=177')
vim.cmd('hi DapUILineNumber ctermfg=51')
vim.cmd('hi link DapUIFloatNormal NormalFloat')
vim.cmd('hi DapUIFloatBorder ctermfg=51')
vim.cmd('hi DapUIWatchesEmpty ctermfg=197')
vim.cmd('hi DapUIWatchesValue ctermfg=155')
vim.cmd('hi DapUIWatchesError ctermfg=197')
vim.cmd('hi DapUIBreakpointsPath ctermfg=51')
vim.cmd('hi DapUIBreakpointsInfo ctermfg=155')
vim.cmd('hi DapUIBreakpointsCurrentLine ctermfg=155 gui=bold')
vim.cmd('hi link DapUIBreakpointsLine DapUILineNumber')
vim.cmd('hi DapUIBreakpointsDisabledLine ctermfg=59')
vim.cmd('hi link DapUICurrentFrameName DapUIBreakpointsCurrentLine')
vim.cmd('hi DapUIStepOver ctermfg=51')
vim.cmd('hi DapUIStepInto ctermfg=51')
vim.cmd('hi DapUIStepBack ctermfg=51')
vim.cmd('hi DapUIStepOut ctermfg=51')
vim.cmd('hi DapUIStop ctermfg=197')
vim.cmd('hi DapUIPlayPause ctermfg=155')
vim.cmd('hi DapUIRestart ctermfg=155')
vim.cmd('hi DapUIUnavailable ctermfg=59')
vim.cmd('hi DapUIWinSelect ctermfg=51 gui=bold')
vim.cmd('hi link DapUIEndofBuffer EndofBuffer')

-- lsp
vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

vim.lsp.config('*', {
    root_markers = { '.git' },
})

vim.lsp.enable("pyright")
vim.lsp.enable("eslint")
vim.lsp.enable("ruff")

-- Current Word
vim.cmd('hi CurrentWordTwins ctermfg=255 ctermbg=32 cterm=bold')

-- trouble
require("trouble").setup {
    icons = {
        indent = {
            fold_open = "v",
            fold_closed = ">",
        },
        folder_closed = ">",
        folder_open = "v",
    },
    indent_lines = false,
    auto_preview = false,
    mode = "diagnostics",
    signs = {
        error = "E",
        warning = "W",
        hint = "H",
        information = "I",
        other = "?"
    },
    use_diagnostic_signs = false
}

local function trouble_toggle()
    local trouble = require("trouble")
    if trouble.is_open() then
        vim.cmd("Trouble close")
    else
        vim.cmd("Trouble diagnostics")
    end
end

vim.keymap.set('n', 'T', trouble_toggle, { noremap = true, desc = "Toggle Trouble" })

-- vcoolor
vim.g.vcoolor_lowercase = 1

-- neoformat
vim.g.neoformat_enabled_python = {'black'}
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.keymap.set('n', '<leader>j', ':Neoformat<CR>', { noremap = true, desc = "Format code" })

-- copilot
vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)')

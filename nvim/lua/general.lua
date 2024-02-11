local cmd = vim.cmd
local set = vim.opt

-- syntax highlighting
cmd [[
syntax on
syntax enable
]]

-- column guide
set.colorcolumn = "80"
-- folding [in markdown]
set.foldenable = false
-- menu for command completions
set.wildmenu = true
-- spellcheck language(s)
set.spelllang = 'en_us'
-- spellcheck
set.spell = false
-- highlight entire cursor line
set.cursorline = true
-- minimal lines above/below cursor
set.scrolloff = 2
-- line numbers
set.number = true
-- relative line numbers from current line
set.relativenumber = true
-- wrap long lines
set.linebreak = true
-- show mode in command area
set.showmode = false
-- [inc|dec]rememnting alpha characters
cmd [[ set nrformats+=alpha ]]
-- <tab> = # spaces
set.tabstop = 3
-- << and >> # of spaces (0 -> tabstop)
set.shiftwidth = 0
-- default to spaces instead of tab characters
set.expandtab = true
-- new window appears to right of current one
set.splitright = true
-- always show sign column w gitgutter
set.signcolumn = "yes"
-- update interval for gitgutter and stuff
set.updatetime = 300
-- actual mouse support
set.mouse =

-- enable filetype-specific configuration files
cmd 'filetype plugin indent on'
cmd 'filetype detect'

-- disable line numbers in terminal buffers
cmd 'autocmd TermOpen * setlocal nonumber norelativenumber'

-- comment styles for plugin tpope/commentary
cmd [[
augroup init
" remove all autocmds to prevent duplicates
autocmd!
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
autocmd FileType fish          setlocal commentstring=#\ %s
autocmd FileType nix             setlocal commentstring=#\ %s
augroup end
]]

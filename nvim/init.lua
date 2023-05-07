-- massivebird's neovim configuration

-- global variables ------------------------------

local cmd = vim.cmd
local set = vim.opt
local setkeymap = vim.keymap.set

-- space bar as leader
vim.g.mapleader = ' '

-- package manager: folke/lazy.nvim --------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = {
    -- native fallback colorscheme
    colorscheme = { "koehler" },
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})

-- general settings -------------------------------

-- color nonsense
cmd 'let base16colorspace = 256'
if vim.fn.has("termguicolors") then
  set.termguicolors = true
end

-- syntax highlighting
cmd [[
syntax on
syntax enable
]]

-- folding [in markdown]
set.foldenable = false;
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
" commentstring keeps terminating at # character
" autocmd FileType fish          setlocal commentstring=#\ %s
augroup end
]]

-- colorscheme switcher --------------------------

local colorscheme_option = 0

if colorscheme_option == 0 then
  cmd 'colorscheme framer_syntax_dark'
elseif colorscheme_option == 1 then
  cmd 'colorscheme slate'
end

-- functions, commands ---------------------------

-- edit init.lua
cmd [[ command! Nc :e ~/.config/nvim/init.lua ]]

local file_exists = function(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

-- note-querying function
-- github.com/connermcd
cmd [[command! -nargs=1 Ngrep vimgrep "<args>\c" $NOTES_DIR/*/*/*.md]]

-- I never got this to work
-- fun! MyNgrep(query, ...)
-- let query = "/".a:query."/j"
-- let course = get(a:, 1, "")
-- let path = "$NOTES_DIR/" . course . "*/*/*.md"
-- if course == ""
--    let path = "$NOTES_DIR/*/*/*.md"
-- else
--    let path = "$NOTES_DIR/" . course . "*/*/*.md"
--    endif
--    echom query path
--    execute "vimgrep" query path bufname("#")
--    endfunction
--    command! -nargs=+ Ngrepg call MyNgrep(<f-args>)
--    command! -nargs=* Ngrepa vimgrep "<args>\c" $NOTES_DIR/*/*/*.md


-- identify highlight group under cursor
cmd [[
function! SynGroup()
let l:s = synID(line('.'), col('.'), 1)
echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
nnoremap <leader>hg :call SynGroup()<cr>
command! SynGroup call SynGroup()
]]

-- coc: bind <tab>
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- lang: python ----------------------------------

if file_exists('/usr/bin/python3.10') then
  -- laptop
  vim.g['python3_host_prog'] = '/usr/bin/python3.10'
else
  -- desktop
  vim.g['python3_host_prog'] = '/usr/bin/python3.8'
end

-- keymaps, remaps, keybinds ---------------------

-- saving and quitting
setkeymap('n', '<leader>w', ':w!<cr>', {silent = true})
setkeymap('n', '<leader>q', ':wq<cr>', {silent = true})
setkeymap('n', '<leader>Q', ':q!<cr>', {silent = true})

-- close window
setkeymap('n', '<leader>c', ':close<cr>', {silent = true})

-- rewrite entire document
setkeymap('n', 'cA', 'ggcG')

-- redo
setkeymap('n', 'U', '<C-r>')

-- reload configuration file(s)
setkeymap('n', '<leader>s', ':source ~/.config/nvim/init.lua<cr>', {silent = true})

-- packer commands
-- setkeymap('n', '<leader>pc', ':PackerCompile<cr>', {silent = true}) -- regen changed plugin config
-- setkeymap('n', '<leader>pi', ':PackerInstall<cr>', {silent = true}) -- clean, install missing
-- setkeymap('n', '<leader>ps', ':PackerSync<cr>', {silent = true})    -- update, compile
-- setkeymap('n', '<leader>pu', ':PackerUpdate<cr>', {silent = true})  -- clean, update

-- initiate terminal mode
setkeymap('n', '<leader>t', ':term<cr>', {silent = true})

-- exit terminal mode
setkeymap('t', '<Esc>', '<C-\\><C-n>')

-- stop highlighting text (useful after search/substitute)
setkeymap('n', '<leader>n', ':noh<cr>', {silent = true})

-- initiate global substitute
setkeymap('n', '<leader>S', ':%s//g<Left><Left>')

-- search defaults to case insensitive
setkeymap('n', '/', ':/\\c<Left><Left>')

-- searching in visual mode searches only selected area
setkeymap('v', '/', '<Esc>:/\\%V\\c<Left><Left>')

-- view registers
setkeymap('n', '<leader>r', ':registers<cr>', {silent = true})

-- buffer controls
setkeymap('n', '<leader>bn', ':bn<cr>', {silent = true})
setkeymap('n', '<leader>bp', ':bp<cr>', {silent = true})
setkeymap('n', '<leader>bd', ':Bdelete<cr>', {silent = true})

-- because it was doing strange things >:(
setkeymap('n', '<leader><Esc>', '<Nop>')

-- move line up/down
setkeymap('n', '<A-j>', ':m .+1<CR>==')
setkeymap('n', '<A-k>', ':m .-2<CR>==')
setkeymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
setkeymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
-- setkeymap('v', '<A-j>', ':m '>+1<CR>gv=gv')
-- setkeymap('v', '<A-k>', ':m '<-2<CR>gv=gv')

-- resize window
setkeymap('n', '<Up>',    ':resize +2<cr>', {silent = true})
setkeymap('n', '<Down>',  ':resize -2<cr>', {silent = true})
setkeymap('n', '<Right>', ':vertical resize +2<cr>', {silent = true})
setkeymap('n', '<Left>',  ':vertical resize -2<cr>', {silent = true})

-- create new line above or below current line
setkeymap('n', '<leader>o', 'o<Up><Esc>')
setkeymap('n', '<leader>O', 'O<Down><Esc>')

-- fix indentation of entire file
setkeymap('n', '<F7>', 'mZgg=G`Z')

-- toggle spelling
setkeymap('n', '<leader>d', ':set spell!<cr>')

-- conjure: evaluations
setkeymap('n', '<leader>e', ':%ConjureEval<cr>')
-- setkeymap('n', '<leader>f', ':ConjureEvalCurrentForm<cr>')

-- clojure: (1) Creates conjure log in right-hand window (2) launches REPL in new tab
setkeymap('n', '<leader>CL', ':ConjureLogVSplit<cr><C-w>L:tabnew<cr>:term<cr>ibash ~/.clojure/startserver.sh<Enter><C-\\><C-n>:tabprevious<cr><C-w>h')

-- navigate vimgrep ft. looping quickfix navigation
cmd [[
command! Cprev try | cprev | catch | clast | catch | endtry
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
]]

-- navigate quickfix list
setkeymap('n', '<C-p>',     ':Cnext<cr>', {silent = true})
setkeymap('n', '<C-o>',     ':Cprev<cr>', {silent = true})
setkeymap('n', '<leader>[', ':Ngrep ' )

-- get rid of weird location list error
setkeymap('n', '<esc>', '<nop>')

-- I HATE ex mode
setkeymap('n', 'Q', '<Nop>')

-- place semicolon at end of current line
setkeymap('n', '<leader>;', 'mY:s/$/;<cr>:noh<cr>`Y', {silent = true})

-- open/close fold under cursor
setkeymap('n', 'zl', 'zA', {silent = true})
setkeymap('n', 'zh', 'zC', {silent = true})

-- Diagnostic keymaps
setkeymap('n', '[d', vim.diagnostic.goto_prev)
setkeymap('n', ']d', vim.diagnostic.goto_next)
-- setkeymap('n', '<leader>e', vim.diagnostic.open_float)
-- setkeymap('n', '<leader>q', vim.diagnostic.setloclist)

-- keymaps: Stel's navigation solutions ----------
-- github.com/stelcodes/xdg-config

-- move to tab by index
setkeymap('n', '<leader>1', '1gt')
setkeymap('n', '<leader>2', '2g <leader>3 3gt')
setkeymap('n', '<leader>4', '4g <leader>5 5gt')
setkeymap('n', '<leader>6', '6g <leader>7 7gt')
setkeymap('n', '<leader>8', '8g <leader>9 9gt')
setkeymap('n', '<leader>0', ':tablast<cr>')

-- tab moves cursor 10 lines down, shift-tab 10 lines up
setkeymap('n', '<tab>',   '10j')
setkeymap('n', '<s-tab>', '10k')

-- navigate windows in a way that actually makes sense
setkeymap('n', '<c-j>', '<C-w>j')
setkeymap('n', '<c-k>', '<C-w>k')
setkeymap('n', '<c-h>', '<c-w>h')
setkeymap('n', '<c-l>', '<c-w>l')

-- presentation mode
setkeymap('n', '<c-p>', ':set signcolumn=yes:9 showmode! relativenumber! number!<cr>:GitGutterDisable<cr>:CocDisable<cr>')

-- lazy.nvim window
setkeymap('n', '<leader>L', ':Lazy<cr>')

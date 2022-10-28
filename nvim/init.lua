-- global variables ------------------------------

local cmd = vim.cmd
local set = vim.opt
local setkeymap = vim.keymap.set

-- plugin manager: vim-plug ----------------------

-- `config = function()` NOT RUNNING??

-- for bootstrapping packer
-- https://github.com/wbthomason/packer.nvim#bootstrapping

local ensure_packer = function()
   local fn = vim.fn
   local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
   if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
      vim.cmd [[packadd packer.nvim]]
      return true
   end
   return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')
packer.startup(function(use)

   -- packer manages packer itself,
   -- packer is very powerful
   use 'wbthomason/packer.nvim'

   -- tim pope's dark arts
   use 'tpope/vim-commentary'
   use 'tpope/vim-fugitive'
   use 'tpope/vim-sensible'
   use 'tpope/vim-surround'
   use 'tpope/vim-obsession'
   use 'tpope/vim-abolish'

   -- status line
   use 'itchyny/lightline.vim'

   -- [hex] color highlighter
   -- top one is prob deprecated
   use 'ap/vim-css-color'
   use {
      'rrethy/vim-hexokinase',
      -- go to ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase/hexokinase
      ['do'] = 'make hexokinase && cp ./hexokinase/hexokinase /usr/bin/hexokinase',
   }

   -- colorschemes
   use 'rafi/awesome-vim-colorschemes'
   use 'evprkr/galaxian-vim'
   use 'ghifarit53/tokyonight-vim'
   use 'massivebird/vim-framer-syntax'
   use 'neozenith/estilo-xoria256'

   -- autocomplete braces and scopes
   use 'jiangmiao/auto-pairs'

   -- live version control feedback
   use 'airblade/vim-gitgutter'

   -- markdown: features
   use {
      'plasticboy/vim-markdown',
      config = function()
         set.conceallevel = 2
         vim.g['vim_markdown_folding_disabled'] = 0
         vim.g['vim_markdown_folding_level'] = 3
      end
   }
   -- markdown: preview in web browser
   use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function() vim.g.mkdp_filetypes = { 'markdown' } end,
      ft = { 'markdown' }
   }

   -- clojure support
   use {
      'olical/conjure',
      config = function()
         vim.g.ale_linters = {
            ['*'] = {'ale_linters'},
            ['clojure'] = {'clj-kondo'},
            ['lua'] = {'luacheck'}
         }
      end
   }
   use 'tpope/vim-dispatch'
   use 'tpope/vim-fireplace'
   use 'clojure-vim/vim-jack-in'
   use 'radenling/vim-dispatch-neovim'

   use 'p00f/nvim-ts-rainbow'

   -- treesitter
   -- exe installer: `npm install -g tree-sitter-cli`
   use {
      'nvim-treesitter/nvim-treesitter',
      -- ['do'] = ':TSUpdate',
      config = function()
         require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "php", "python", "clojure", "rust", "html", "css", "markdown", "vim", "fish", "json" },
            ignore_install = {},
            auto_install = true,
            indent = {
               enable = true,
            },
            highlight = {
               enable = true,              -- false will disable the whole extension
               disable = {"vim", "markdown", "html", "php"},  -- list of language that will be disabled
               -- true, false, or list of languages
               -- may slow editor
               -- additional_vim_regex_highlighting = true,
            },
            -- rainbow parentheses/brackets
            rainbow = {
               enable = true,
               disable = { "jsx", "cpp", "html", "php"}, -- list of languages you want to disable the plugin for
               extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
               max_file_lines = nil, -- Do not enable for files with more than n lines, int
               -- colors = {}, -- table of hex strings
               -- termcolors = {} -- table of colour name strings
            },
         }
      end
   }

   -- autocomplete, suggestions, so delicious
   use {
      'neoclide/coc.nvim',
      ['branch'] = 'release',
      config = function()
         -- snippet: use <C-j> for jump to next placeholder, it's default of coc.nvim
         vim.g['coc_snippet_next'] = '<c-j>'
         -- snippet: use <C-k> for jump to previous placeholder, it's default of coc.nvim
         vim.g['coc_snippet_prev'] = '<c-k>'
      end
   }

   -- snippets
   use {
      'sirver/ultisnips',
      config = function()
         -- edit snippets in vertical window
         vim.g.UltiSnipsEditSplit = 'vertical'
         vim.g['UltiSnipsEditSplit'] = 'vertical'
         cmd 'let g:UltiSnipsEditSplit="vertical"'
         -- remaps
         vim.g['UltiSnipsExpandTrigger'] = '<Nop>'
         vim.g['UltiSnipsListSnippets'] = '<Nop>'
         vim.g['UltiSnipsJumpForwardTrigger'] = '<Nop>'
         vim.g['UltiSnipsJumpBackwardTrigger'] = '<Nop>'
      end
   }

   -- Automatically set up your configuration after cloning packer.nvim
   -- Must be ran after all plugins are defined
   if packer_bootstrap then
      packer.sync()
   end

end)

-- general settings ------------------------------

-- syntax highlighting
cmd [[
syntax on
syntax enable
]]
-- menu for command line completions
set.wildmenu = true
-- spellcheck languages
set.spelllang = 'en_us'
-- spellcheck
set.spell = false
-- highlight entire line
set.cursorline = true
-- line numbers
set.number = true
-- line numbers are relative to current line
set.relativenumber = true
-- wrap long lines
set.linebreak = true
-- show mode in command area
set.showmode = false
-- allows [inc|dec]rememnting letters
cmd [[ set nrformats+=alpha ]]
-- num of spaces <tab> accounts for
set.tabstop = 3
-- num spaces << and >> account for (0 -> tabstop)
set.shiftwidth = 0
-- use spaces instead of tab characters
set.expandtab = true
-- new window appears to right of current one
set.splitright = true
-- always show sign column, would otherwise shift text every time
set.signcolumn = "yes"
-- default updatetime is 4000ms, too slow
set.updatetime = 300
-- enable filetype-specific configuration files
cmd 'filetype plugin on'

cmd 'autocmd TermOpen * setlocal nonumber norelativenumber'

-- color nonsense
cmd 'let base16colorspace = 256'
if vim.fn.has("termguicolors") then
   set.termguicolors = true
end

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
   vim.g['lightline'] = {['colorscheme'] = 'framer_dark'}
elseif colorscheme_option == 1 then
   cmd 'colorscheme xoria256'
   vim.g['lightline'] = {['colorscheme'] = 'xoria256'}
end

-- functions -------------------------------------

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- note-querying function
-- github.com/connermcd
cmd [[command! -nargs=1 Ngrep vimgrep "<args>\c" $NOTES_DIR/*/*/*.md]]

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

cmd [[ command! LightlineReload call LightlineReload() ]]

function LightlineReload()
   cmd [[
   call lightline#init()
   call lightline#colorscheme()
   call lightline#update()
   ]]
end

--    " identify highlight group under cursor
--    function! SynGroup()
--    let l:s = synID(line('.'), col('.'), 1)
--    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
--    endfun
--    nnoremap <leader>hg :call SynGroup()<cr>
--    ]]

-- lang: python ----------------------------------

if file_exists('/usr/bin/python3.10') then
   -- laptop
   cmd 'let g:python3_host_prog = \'/usr/bin/python3.10\''
else
   -- desktop
   cmd 'let g:python3_host_prog = \'/usr/bin/python3.8\''
end

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

-- keymaps remaps keybinds -----------------------

-- space bar as leader
vim.g.mapleader = ' '

-- saving and quitting
setkeymap('n', '<leader>w',   ':w!<cr>')
setkeymap('n', '<leader>q',   ':wq<cr>')
setkeymap('n', '<leader>Q',   ':q!<cr>')

-- close window
setkeymap('n', '<leader>c',   ':close<cr>')

-- erase entire document
setkeymap('n', '<leader>A',   'ggcG')

-- source init.lua
setkeymap('n', '<leader>s',   ':source ~/.config/nvim/init.lua<cr>')

-- packer commands
setkeymap('n', '<leader>pi',  ':PackerInstall<cr>')
setkeymap('n', '<leader>pc',  ':PackerClean<cr>')
setkeymap('n', '<leader>pu',  ':PackerUpdate<cr>')

-- terminal mode
setkeymap('n', '<leader>t',   ':term<cr>')
-- escape exits terminal mode
setkeymap('t', '<Esc>', '<C-\\><C-n>')

-- redo
setkeymap('n', 'U', '<C-r>')

-- stop highlighting after search/substitute
setkeymap('n', '<leader>n',   ':noh<cr>')

-- initiate global substitute
setkeymap('n', '<leader>S',   ':%s//g<Left><Left>')

-- search defaults to case insensitive
setkeymap('n', '/',           ':/\\c<Left><Left>')

-- view registers
setkeymap('n', '<leader>r', ':registers<cr>')

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
setkeymap('n', '<Up>',    ':resize +2<cr>')
setkeymap('n', '<Down>',  ':resize -2<cr>')
setkeymap('n', '<Right>', ':vertical resize +2<cr>')
setkeymap('n', '<Left>',  ':vertical resize -2<cr>')

-- create new line above or below current line
setkeymap('n', '<leader>o', 'o<Up><Esc>')
setkeymap('n', '<leader>O', 'O<Down><Esc>')

-- fix indentation of entire file
setkeymap('n', '<F7>', 'mtgg=G`t')

-- toggle spelling
setkeymap('n', '<leader>d', ':set spell!<cr>')

-- gitgutter shortcuts
setkeymap('n', '<leader>gn', ':GitGutterNextHunk<cr>')
setkeymap('n', '<leader>gp', ':GitGutterPrevHunk<cr>')
setkeymap('n', '<leader>gv', ':GitGutterPreviewHunk<cr>')
setkeymap('n', '<leader>gu', ':GitGutterUndoHunk<cr>')


-- conjure evaluations
setkeymap('n', '<leader>e', ':%ConjureEval<cr>')
setkeymap('n', '<leader>f', ':ConjureEvalCurrentForm<cr>')

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
setkeymap('n', '<C-p>',     ':Cnext<cr>')
setkeymap('n', '<C-o>',     ':Cprev<cr>')
setkeymap('n', '<leader>[', ':Ngrep' )

-- get rid of weird location list error
setkeymap('n', '<Esc>', '<Nop>')

-- I HATE ex mode
setkeymap('n', 'Q', '<Nop>')

-- place semicolon at end of current line
setkeymap('n', '<leader>;', 'mY:s/$/;<cr>:noh<cr>`Y', {silent = true})

-- open/close fold under cursor
setkeymap('n', 'zl', 'zA')
setkeymap('n', 'zh', 'zC')

-- coc: dismiss completion list without completion
setkeymap('i', '<C-Enter>', '<Space>')

-- coc: tab to go down
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
setkeymap('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)

-- coc: shift tab to go up
setkeymap('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- coc: enter selects first/selected item
-- do NOT change these double quotes to single quotes
setkeymap('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- coc: reopen completion menu without typing
setkeymap('i', '<c-space>', 'coc#refresh()', {silent = true, expr = true})

-- coc-snippet: insert snippet
-- cmd [[imap <C-l> <Plug>(coc-snippets-expand)]]
setkeymap('i', '<C-l>', '<Plug>(coc-snippets-expand)')

-- I need the below since `config = function()` does not run
-- cmd [[
-- " let g:UltiSnipsEditSplit="horizontal"

-- " remaps
-- let g:UltiSnipsExpandTrigger="<Nop>"
-- let g:UltiSnipsListSnippets="<Nop>"
-- let g:UltiSnipsJumpForwardTrigger="<Nop>"
-- let g:UltiSnipsJumpBackwardTrigger="<Nop>"
-- let g:coc_snippet_next = '<c-j>'
-- " snippet: use <C-k> for jump to previous placeholder, it's default of coc.nvim
-- let g:coc_snippet_prev = '<c-k>'
-- ]]

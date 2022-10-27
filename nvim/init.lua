-- plugin manager: vim-plug ---------------------
-- `config = function()` NOT RUNNING
local packer = require('packer')
packer.startup(function(use)

   use 'wbthomason/packer.nvim'

   -- tim pope's dark arts
   use 'tpope/vim-commentary'
   use 'tpope/vim-fugitive'
   use 'tpope/vim-sensible'
   use 'tpope/vim-surround'
   use 'tpope/vim-obsession'
   use 'tpope/vim-abolish'

   -- hip status line
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

   -- active version control feedback
   use 'airblade/vim-gitgutter'

   -- markdown support
   use {
      'plasticboy/vim-markdown',
      config = function()
         vim.opt.conceallevel = 2
         vim.g['vim_markdown_folding_disabled'] = 0
         vim.g['vim_markdown_folding_level'] = 3
      end
   }
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

   -- treesitter
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

   use 'p00f/nvim-ts-rainbow'

   -- autocomplete, suggestions
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
         vim.g['UltiSnipsEditSplit'] = 'horizontal'
         -- remaps
         vim.g['UltiSnipsExpandTrigger'] = '<Nop>'
         vim.g['UltiSnipsListSnippets'] = '<Nop>'
         vim.g['UltiSnipsJumpForwardTrigger'] = '<Nop>'
         vim.g['UltiSnipsJumpBackwardTrigger'] = '<Nop>'
      end
   }

end)

-- general settings -----------------------------

-- syntax highlighting
vim.cmd [[
syntax on
syntax enable
]]
-- menu for command line completions
vim.opt.wildmenu = true
-- spellcheck languages
vim.opt.spelllang = 'en_us'
-- spellcheck
vim.opt.spell = false
-- highlight entire line
vim.opt.cursorline = true
-- line numbers
vim.opt.number = true
-- line numbers are relative to current line
vim.opt.relativenumber = true
-- wrap long lines
vim.opt.linebreak = true
-- show mode in command area
vim.opt.showmode = false
-- allows [inc|dec]rememnting letters
-- set.nrformats += 'alpha'
-- num spaces <Tab> accounts for
vim.opt.tabstop = 3
-- num spaces << and >> account for (0 -> tabstop)
vim.opt.shiftwidth = 0
-- use spaces instead of tab characters
vim.opt.expandtab = true
-- new window appears to right of current one
vim.opt.splitright = true
-- enable filetype-specific configuration files
vim.cmd 'filetype plugin on'

vim.cmd 'autocmd TermOpen * setlocal nonumber norelativenumber'

-- color nonsense
-- local base16colorspace = 256
if vim.fn.has("termguicolors") then
   vim.opt.termguicolors = true
end

-- comment styles for plugin tpope/commentary
vim.cmd 'autocmd FileType c,cpp,cs,java setlocal commentstring=// %s'
vim.cmd 'autocmd FileType fish          setlocal commentstring=# %s'

-- colorscheme switcher -------------------------

local colorscheme_option = 0

if colorscheme_option == 0 then
   vim.cmd 'colorscheme framer_syntax_dark'
   vim.g['lightline'] = {['colorscheme'] = 'framer_dark'}
elseif colorscheme_option == 1 then
   vim.cmd 'colorscheme xoria256'
   vim.g['lightline'] = {['colorscheme'] = 'xoria256'}
end

-- functions ------------------------------------

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- note-querying function
-- github.com/connermcd

-- vim.cmd [[
-- command! -nargs=1 Ngrep vimgrep "<args>\c" $NOTES_DIR/*/*/*.md

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

--    command! LightlineReload call LightlineReload()

--    function! LightlineReload()
--    call lightline#init()
--    call lightline#colorscheme()
--    call lightline#update()
--    endfunction

--    " identify highlight group under cursor
--    function! SynGroup()
--    let l:s = synID(line('.'), col('.'), 1)
--    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
--    endfun
--    nnoremap <leader>hg :call SynGroup()<cr>
--    ]]

-- lang: python ---------------------------------

if file_exists('/usr/bin/python3.10') then
   -- laptop
   vim.cmd 'let g:python3_host_prog = \'/usr/bin/python3.10\''
else
   -- desktop
   vim.cmd 'let g:python3_host_prog = \'/usr/bin/python3.8\''
end

-- Stel's navigation solutions ------------------

-- github.com/stelcodes/xdg-config

-- ctrl-[hjkl] moves window focus in that direction, moving to another tab (if necessary)
-- vim.cmd [[
-- function! MoveLeft()
-- if (winnr() == winnr('1h'))
--    :tabprevious
-- else
--    :call nvim_input("<Esc><C-w>h")
--    endif
--    endfunction

--    function! MoveRight()
--    if (winnr() == winnr('1l'))
--       :tabnext
--    else
--       :call nvim_input("<Esc><C-w>l")
--       endif
--       endfunction

--       nnoremap <C-j> <C-w>j
--       nnoremap <C-k> <C-w>k
--       nnoremap <C-h> :call MoveLeft()<CR>
--       nnoremap <C-l> :call MoveRight()<CR>

--       inoremap <C-j> <Esc><C-w>j
--       inoremap <C-k> <Esc><C-w>k
--       inoremap <C-h> <Esc>:call MoveLeft()<CR>
--       inoremap <C-l> <Esc>:call MoveRight()<CR>

--       tnoremap <C-j> <C-\><C-n><C-w>j
--       tnoremap <C-k> <C-\><C-n><C-w>k
--       tnoremap <C-h> <C-\><C-n>:call MoveLeft()<CR>
--       tnoremap <C-l> <C-\><C-n>:call MoveRight()<CR>
--       nnoremap <C-l> <C-\><C-n>:call MoveRight()<CR>

--       " move to tab by index
--       noremap <leader>1 1gt
--       noremap <leader>2 2gt
--       noremap <leader>3 3gt
--       noremap <leader>4 4gt
--       noremap <leader>5 5gt
--       noremap <leader>6 6gt
--       noremap <leader>7 7gt
--       noremap <leader>8 8gt
--       noremap <leader>9 9gt
--       noremap <leader>0 :tablast<cr>

--       " tab moves cursor 10 lines down, shift-tab 10 lines up
--       nnoremap <silent> <TAB> 10j
--       nnoremap <silent> <S-TAB> 10k

--       " move through wrapped lines visually
--       nnoremap j gj
--       nnoremap k gk
--       ]]

-- remaps keymaps keybinds ----------------------

-- space bar as leader
vim.g.mapleader = ' '

-- essentials
vim.keymap.set('n', '<leader>w',   ':w!<cr>')
vim.keymap.set('n', '<leader>q',   ':wq<cr>')
vim.keymap.set('n', '<leader>Q',   ':q!<cr>')
vim.keymap.set('n', '<leader>c',   ':close<cr>')
vim.keymap.set('n', '<leader>A',   'ggcG')
vim.keymap.set('n', '<leader>s',   ':source ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<leader>pi',  ':PackerInstall<cr>')
vim.keymap.set('n', '<leader>pc',  ':PackerClean<cr>')
vim.keymap.set('n', '<leader>pu',  ':PackerUpdate<cr>')
vim.keymap.set('n', '<leader>t',   ':term<cr>')
vim.keymap.set('n', '<leader>n',   ':noh<cr>')
vim.keymap.set('n', '<leader>S',   ':%s//g<Left><Left>')
vim.keymap.set('n', '/',           ':/\\c<Left><Left>')

-- redo
vim.keymap.set('n', 'U', '<C-r>')

-- escape exits terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- view registers
vim.keymap.set('n', '<leader>r', ':registers<cr>')

-- because it was doing strange things >:(
vim.keymap.set('n', '<leader><Esc>', '<Nop>')

-- move line up/down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
-- vim.keymap.set('v', '<A-j>', ':m '>+1<CR>gv=gv')
-- vim.keymap.set('v', '<A-k>', ':m '<-2<CR>gv=gv')

-- window resizing
vim.keymap.set('n', '<Up>',    ':resize +2<cr>')
vim.keymap.set('n', '<Down>',  ':resize -2<cr>')
vim.keymap.set('n', '<Right>', ':vertical resize +2<cr>')
vim.keymap.set('n', '<Left>',  ':vertical resize -2<cr>')

-- create new line above or below current line
vim.keymap.set('n', '<leader>o', 'o<Up><Esc>')
vim.keymap.set('n', '<leader>O', 'O<Down><Esc>')

-- fix indentation of entire file (deprecated soon probably)
vim.keymap.set('n', '<F7>', 'gg=G<C-o><C-o><C-o>')

-- toggle spelling, wrap mode
vim.keymap.set('n', '<leader>d', ':set spell!<cr>')

-- conjure evaluations
vim.keymap.set('n', '<leader>e', ':%ConjureEval<cr>')
vim.keymap.set('n', '<leader>f', ':ConjureEvalCurrentForm<cr>')

-- clojure: (1) Creates conjure log in right-hand window (2) launches REPL in new tab
vim.keymap.set('n', '<leader>CL', ':ConjureLogVSplit<cr><C-w>L:tabnew<cr>:term<cr>ibash ~/.clojure/startserver.sh<Enter><C-\\><C-n>:tabprevious<cr><C-w>h')

-- vimgrep navigation ft. looping quickfix navigation
vim.cmd [[
command! Cprev try | cprev | catch | clast | catch | endtry
command! Cnext try | cnext | catch | cfirst | catch | endtry

command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
]]

-- quickfix list nav remaps
vim.keymap.set('n', '<C-p>',     ':Cnext<cr>')
vim.keymap.set('n', '<C-o>',     ':Cprev<cr>')
vim.keymap.set('n', '<leader>[', ':Ngrep' )

-- get rid of weird location list error
vim.keymap.set('n', '<Esc>', '<Nop>')

-- I HATE ex mode
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', '<silent>', '<leader>; mY:s/$/;<cr>:noh<cr>`Y')

-- places semicolon at end of current line

-- markdown
vim.keymap.set('n', 'zl', 'zA')
vim.keymap.set('n', 'zh', 'zC')

-- coc keybinds
-- ctrl+enter dismisses completion list without completion
vim.keymap.set('i', '<C-Enter>', '<Space>')
-- tab to go down
vim.cmd [[inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"]]
-- shift tab to go down
vim.cmd [[inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "<S-Tab>"]]
-- enter selects first/selected item
vim.cmd [[inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>" ]]
-- reopens coc completion menu without typing
vim.cmd [[inoremap <silent><expr> <c-space> coc#refresh()]]
-- snippet: insert snippet
vim.cmd [[imap <C-l> <Plug>(coc-snippets-expand)]]

-- gitgutter shortcuts
vim.keymap.set('n', '<leader>gn', ':GitGutterNextHunk<cr>')
vim.keymap.set('n', '<leader>gp', ':GitGutterPrevHunk<cr>')
vim.keymap.set('n', '<leader>gv', ':GitGutterPreviewHunk<cr>')
vim.keymap.set('n', '<leader>gu', ':GitGutterUndoHunk<cr>')

-- I need the below since `config = function()` does not run
vim.cmd [[
let g:UltiSnipsEditSplit="horizontal"

" remaps
let g:UltiSnipsExpandTrigger="<Nop>"
let g:UltiSnipsListSnippets="<Nop>"
let g:UltiSnipsJumpForwardTrigger="<Nop>"
let g:UltiSnipsJumpBackwardTrigger="<Nop>"
let g:coc_snippet_next = '<c-j>'
" snippet: use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
]]

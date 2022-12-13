-- massivebird's neovim configuration

-- global variables ------------------------------

local cmd = vim.cmd
local set = vim.opt
local setkeymap = vim.keymap.set

-- plugin manager: packer ------------------------

-- bootstrapping packer
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

-- loading plugins
local packer = require('packer')
packer.startup(function(use)

   -- packer manages packer itself,
   -- packer is very powerful
   use 'wbthomason/packer.nvim'

   -- default options
   use 'tpope/vim-sensible'
   -- comment stuff out
   use 'tpope/vim-commentary'
   -- git commands like :G and :g?
   use 'tpope/vim-fugitive'
   -- parentheses/tags/brackets editing
   use 'tpope/vim-surround'
   -- search/substitute/abbreviate words
   use 'tpope/vim-abolish'
   -- repeat supported plugin actions with `.`
   use 'tpope/vim-repeat'

   -- autocomplete braces and scopes
   use 'jiangmiao/auto-pairs'

   -- live version control feedback
   use 'airblade/vim-gitgutter'

   -- colorschemes
   use 'evprkr/galaxian-vim'
   use 'massivebird/vim-framer-syntax'
   use 'chriskempson/base16-vim'

   -- close buffer without closing window with :Bdelete
   use 'moll/vim-bbye'

   -- status line
   use 'itchyny/lightline.vim'

   -- fuzzy finder
   use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = {
         'nvim-lua/plenary.nvim',
         { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
         'nvim-telescope/telescope-ui-select.nvim',
         'nvim-telescope/telescope-file-browser.nvim',
      },
      config = function()
         -- https://github.com/nvim-telescope/telescope.nvim#previewers
         local tele = require('telescope')
         local builtin = require('telescope.builtin')
         local actions = require('telescope.actions')
         local browser = tele.extensions.file_browser

         local find_files_from_root = function()
            builtin.find_files {
               hidden = true,
               no_ignore = true,
               no_ignore_parent = true,
               search_dirs = {'/home'}
            }
         end
         local browse_notes = function()
            builtin.live_grep {
               prompt_title = "Search notes",
               hidden = true,
               respect_gitignore = false,
               grep_open_files = false,
               type_filter = "markdown",
               -- cwd = '/home/penguino/academia/notes_all/*'
            }
         end
         local grep_in_open_buffers = function()
            builtin.live_grep {
               prompt_title = "Grep in buffers",
               grep_open_files = true,
               hidden = true,
               respect_gitignore = false,
               path_display = {"tail"},
               disable_coordinates = true
            }
         end

         tele.setup {
            defaults = {
               file_ignore_patterns = {
                  '%.pdf$', '%.db$', '%.opus$', '%.mp3$', '%.wav$', '%.git/', '%.git.*', '%.clj%-kondo/%.cache/', '%.lsp/', '%.cpcache/', '%target/'
               },
               -- prompt_title = false,
               results_title = false,
               -- preview_title = false,
               prompt_prefix = '  ',
               -- selection_caret = '  ',
               path_display = {"truncate"},
               layout_config = {
                  prompt_position = 'bottom'
               },
               width = 0.8
            },
            pickers = {
               find_files = {
                  find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                  results_title = false,
                  prompt_title = false,
                  previewer = false,
               },
               live_grep = {
                  results_title = false,
                  prompt_title = false,
               },
            },
         }

         tele.load_extension('fzf')
         tele.load_extension('file_browser')
         tele.load_extension('ui-select')

         vim.keymap.set('n', '<leader>fb', builtin.buffers)
         vim.keymap.set('n', '<leader>ff', builtin.find_files)
         vim.keymap.set('n', '<leader>fg', builtin.live_grep)
         vim.keymap.set('n', '<leader>fh', builtin.help_tags)
         vim.keymap.set('n', '<leader>fH', builtin.highlights)
         vim.keymap.set('n', '<leader>fj', builtin.jumplist)
         vim.keymap.set('n', '<leader>fl', grep_in_open_buffers)
         vim.keymap.set('n', '<leader>fn', browse_notes)
         vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
         vim.keymap.set('n', '<leader>fr', find_files_from_root)
         vim.keymap.set('n', '<leader>fv', builtin.vim_options)

      end
      -- ^ end of config = function()
   }

   -- color highlighter
   -- use {
   --    'rrethy/vim-hexokinase',
   --    -- go to ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase/hexokinase
   --    -- and run `go build`
   --    ['do'] = 'make hexokinase && cp ./hexokinase/hexokinase /usr/bin/hexokinase',
   --    setup = function()
   --       vim.g.Hexokinase_highlighters = {'backgroundfull'}
   --    end
   -- }

   -- markdown: features
   use 'godlygeek/tabular'
   use {
      'preservim/vim-markdown',
      config = function()
         vim.opt.conceallevel = 2
         -- vim.g['vim_markdown_folding_disabled'] = 0
         -- vim.g['vim_markdown_folding_level'] = 3
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

   -- clojure: misc
   use 'tpope/vim-dispatch'
   use 'tpope/vim-fireplace'
   use 'clojure-vim/vim-jack-in'
   use 'radenling/vim-dispatch-neovim'

   -- rainbow parentheses
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
               enable = true,
               -- true, false, or list of languages
               disable = {"vim", "markdown", "html", "php", "gitcommit"},
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

   -- intellisense engine
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
         vim.g['UltiSnipsEditSplit'] = 'horizontal'
         vim.g['UltiSnipsExpandTrigger']       = '<Nop>'
         vim.g['UltiSnipsJumpBackwardTrigger'] = '<Nop>'
         vim.g['UltiSnipsJumpForwardTrigger']  = '<Nop>'
         vim.g['UltiSnipsListSnippets']        = '<Nop>'
      end
   }

   -- automatically set up your configuration after cloning packer.nvim,
   -- must be ran after all plugins are defined
   if packer_bootstrap then
      packer.sync()
   end

end)

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

-- disable folding [in markdown]
set.foldenable = false;
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
-- allows [inc|dec]rememnting letter characters
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
-- disable mouse functionality
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
   vim.g['lightline'] = {['colorscheme'] = 'framer_dark'}
elseif colorscheme_option == 1 then
   cmd 'colorscheme base16-default-dark'
   vim.g['lightline'] = {['colorscheme'] = 'base16-default-dark'}
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

-- reload lightline colorscheme
cmd [[
function! LightlineReload()
   call lightline#init()
   call lightline#colorscheme()
   call lightline#update()
endfunction
command! LightlineReload call LightlineReload() 
   ]]

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

-- space bar as leader
vim.g.mapleader = ' '

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

-- reload configuration files
setkeymap('n', '<leader>s', ':source ~/.config/nvim/init.lua<cr>:LightlineReload<cr>:PackerCompile<cr>', {silent = true})

-- packer commands
setkeymap('n', '<leader>pc', ':PackerCompile<cr>', {silent = true}) -- regen changed plugin config
setkeymap('n', '<leader>pi', ':PackerInstall<cr>', {silent = true}) -- clean, install missing
setkeymap('n', '<leader>ps', ':PackerSync<cr>', {silent = true})    -- update, compile
setkeymap('n', '<leader>pu', ':PackerUpdate<cr>', {silent = true})  -- clean, update

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
setkeymap('n', '<F7>', 'mtgg=G`t')

-- toggle spelling
setkeymap('n', '<leader>d', ':set spell!<cr>')

-- gitgutter shortcuts
setkeymap('n', '<leader>gn', ':GitGutterNextHunk<cr>', {silent = true})
setkeymap('n', '<leader>gp', ':GitGutterPrevHunk<cr>', {silent = true})
setkeymap('n', '<leader>gv', ':GitGutterPreviewHunk<cr>', {silent = true})
setkeymap('n', '<leader>gu', ':GitGutterUndoHunk<cr>', {silent = true})

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

-- coc: dismiss completion list without completion
setkeymap('i', '<c-cr>', 'coc#pum#cancel()')

-- coc: tab to go down
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
setkeymap('i', '<tab>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<tab>" : coc#refresh()', opts)

-- coc: shift tab to go up
setkeymap('i', '<s-tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- coc: enter selects first/selected item
-- do NOT change these double quotes to single quotes
setkeymap('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- coc: reopen completion menu without typing
setkeymap('i', '<c-space>', 'coc#refresh()', {silent = true, expr = true})

-- coc-snippet: insert snippet
-- cmd [[imap <C-l> <Plug>(coc-snippets-expand)]]
setkeymap('i', '<C-l>', '<Plug>(coc-snippets-expand)')

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

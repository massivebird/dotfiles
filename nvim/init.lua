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
   use {
      'airblade/vim-gitgutter',
      config = function()
         -- gitgutter navigation
         vim.keymap.set('n', '<leader>gn', ':GitGutterNextHunk<cr>', {silent = true})
         vim.keymap.set('n', '<leader>gp', ':GitGutterPrevHunk<cr>', {silent = true})
         vim.keymap.set('n', '<leader>gv', ':GitGutterPreviewHunk<cr>', {silent = true})
         vim.keymap.set('n', '<leader>gu', ':GitGutterUndoHunk<cr>', {silent = true})
      end
   }

   -- colorschemes
   use 'evprkr/galaxian-vim'
   use 'massivebird/vim-framer-syntax'
   use 'chriskempson/base16-vim'
   use ({ 'projekt0n/github-nvim-theme', tag = 'v0.0.7' })

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
         -- local actions = require('telescope.actions')
         -- local browser = tele.extensions.file_browser

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
         vim.opt.conceallevel = 0
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
         vim.g['conjure#filetypes'] = {"clojure"}
         vim.g['conjure#mapping#doc-word'] = false
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

	use {
      'nvim-treesitter/nvim-treesitter-context',
      require'treesitter-context'.setup{
         enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
         max_lines = 2,
         -- minimum editor window height to enable context
         min_window_height = 0,
         line_numbers = true,
         -- max number of lines to collapse for a single context line
         multiline_threshold = 10,
         -- which context lines to discard if `max_lines` is exceeded
         trim_scope = 'outer',
         mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
         -- Separator between context and content. Should be a single character string, like '-'.
         -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
         separator = "-",
         zindex = 20, -- The Z-index of the context window
      }
   }

   -- treesitter
   -- exe installer: `npm install -g tree-sitter-cli`
   use {
      'nvim-treesitter/nvim-treesitter',
      ['do'] = ':TSUpdate',
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

   use {
      'neovim/nvim-lspconfig',
      config = function()
         -- https://github.com/neovim/nvim-lspconfig#Keybindings-and-completion
         local lspconfig = require('lspconfig')

         -- Use an on_attach function to only map the following keys
         -- after the language server attaches to the current buffer
         local on_attach = function()
            vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = 0 })
            vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = 0 })
            vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { buffer = 0 })
            vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float, { buffer = 0 })
            vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, { buffer = 0 })
            vim.keymap.set('v', '<leader>lf', function() vim.lsp.buf.range_formatting({}) end, { buffer = 0 })

            -- Add borders to :LspInfo floating window
            -- https://neovim.discourse.group/t/lspinfo-window-border/1566/2
            require('lspconfig.ui.windows').default_options.border = 'rounded'

         end

         lspconfig.clojure_lsp.setup {
            on_attach = on_attach,
         }

         -- lspconfig.lua_ls.setup {
         --    on_attach = on_attach,
         --    settings = {
         --       Lua = {
         --          diagnostics = {
         --             globals = { 'vim' }
         --          }
         --       }
         --    }
         -- }

         lspconfig.gopls.setup {
            on_attach = on_attach,
         }

         -- pip install --user python-lsp-server
         -- lspconfig.pylsp.setup {
         --   on_attach = on_attach,
         -- }

         -- nix-env -iA nixpkgs.pyright
         -- npm install -g pyright
         lspconfig.pyright.setup {
            on_attach = on_attach,
         }

         -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#java_language_server
         lspconfig.java_language_server.setup {
            on_attach = on_attach,
            cmd = { '/home/penguino/java-language-server/dist/lang_server_linux.sh' },
         }

         lspconfig.marksman.setup {
            cmd = {"marksman", "server"},
            filetypes = { "markdown" }
         }

         lspconfig.bashls.setup {
            cmd = {"bash-language-server", "start"},
            filetypes = { "sh" }
         }

         lspconfig.rust_analyzer.setup {
            on_attach = on_attach,
            settings = {
               ["rust-analyzer"] = {
                  assist = {
                     importGranularity = "module",
                     importPrefix = "by_self",
                  },
                  cargo = {
                     loadOutDirsFromCheck = true
                  },
                  procMacro = {
                     enable = true
                  },
               }
            }
         }

         vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "rounded" }
         )
         vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded" }
         )
      end
   }

   -- autocompletion
   use {
      'hrsh7th/nvim-cmp',
      requires = {
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-nvim-lua',
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-path',
         'hrsh7th/cmp-cmdline',
         -- 'L3MON4D3/LuaSnip',
         -- 'saadparwaiz1/cmp_luasnip',
         'onsails/lspkind.nvim'
      },
      config = function()
         local lspkind = require('lspkind')
         lspkind.init()
         local cmp = require('cmp')
         cmp.setup {
            mapping = {
               ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
               ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
               ["<C-d>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<C-e>"] = cmp.mapping.abort(),
               ["<c-y>"] = cmp.mapping(
                  cmp.mapping.confirm {
                     behavior = cmp.ConfirmBehavior.Insert,
                     select = true,
                  },
                  { "i", "c" }
               ),
               ["<c-space>"] = cmp.mapping {
                  i = cmp.mapping.complete(),
                  c = function(
                     _ --[[fallback]]
                  )
                     if cmp.visible() then
                        if not cmp.confirm { select = true } then
                           return
                        end
                     else
                        cmp.complete()
                     end
                  end,
               },
               ["<tab>"] = cmp.config.disable,
               -- Testing
               ["<c-q>"] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
               },
            },

            -- global sources, order = priority
            sources = {
               { name = "nvim_lua" },
               { name = "nvim_lsp" },
               { name = "treesitter" },
               { name = "ultisnips" },
               { name = "path" },
               { name = "dictionary" },
               { name = "buffer", keyword_length = 5 },
            },

            sorting = {
               comparators = {
                  cmp.config.compare.offset,
                  cmp.config.compare.exact,
                  cmp.config.compare.score,

                  function(entry1, entry2)
                     local _, entry1_under = entry1.completion_item.label:find "^_+"
                     local _, entry2_under = entry2.completion_item.label:find "^_+"
                     entry1_under = entry1_under or 0
                     entry2_under = entry2_under or 0
                     if entry1_under > entry2_under then
                        return false
                     elseif entry1_under < entry2_under then
                        return true
                     end
                  end,

                  cmp.config.compare.kind,
                  cmp.config.compare.sort_text,
                  cmp.config.compare.length,
                  cmp.config.compare.order,
               },
            },

            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },

            formatting = {
               format = lspkind.cmp_format {
                  with_text = true,
                  menu = {
                     buffer = "[buf]",
                     nvim_lsp = "[lsp]",
                     nvim_lua = "[api]",
                     path = "[path]",
                     luasnip = "[snip]",
                     gh_issues = "[issues]",
                  },
               },
            },

            experimental = {
               -- ! opt for alt popup style
               native_menu = false,
               -- preview selected text inside buffer
               ghost_text = false,
            },

            window = {
               completion = cmp.config.window.bordered(),
               documentation = cmp.config.window.bordered(),
            },
         } -- end of cmp.setup()

      end -- of config function()
   }

   use {
      'ntpeters/vim-better-whitespace',
      config = function()
         vim.g['current_line_whitespace_disabled_hard'] = 1
         vim.g['better_whitespace_guicolor'] = '#ff5555'
         vim.g['better_whitespace_filetypes_blacklist'] = {
            '', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive'
         }
      end
   }

   -- use {
   --    'lukas-reineke/indent-blankline.nvim',
   --    config = function()
   --       vim.opt.list = true
   --       vim.opt.listchars:append "eol:↴"
   --       require("indent_blankline").setup {
   --          show_end_of_line = true,
   --          space_char_blankline = " ",
   --          show_current_context = true,
   --          show_current_context_start = true,
   --       }
   --    end
   -- }

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

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
      'nvim-telescope/telescope.nvim',
      tag = '0.1.0',
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
               colorscheme = {
                  enable_preview = true,
               }
            },
         }

         tele.load_extension('fzf')
         tele.load_extension('file_browser')
         tele.load_extension('ui-select')

         vim.keymap.set('n', '<leader>fb', builtin.buffers)
         vim.keymap.set('n', '<leader>fc', builtin.colorscheme)
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
         max_lines = 3,
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
            incremental_selection = {
               enable = true,
               keymaps = {
                  -- set to `false` to disable one of the mappings
                  init_selection = "gnn",
                  node_incremental = "grn",
                  scope_incremental = "grc",
                  node_decremental = "grm",
               },
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

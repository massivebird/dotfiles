return {
   {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
         'nvim-lua/plenary.nvim',
         'nvim-telescope/telescope-ui-select.nvim',
         'nvim-telescope/telescope-file-browser.nvim',
         { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
               search_dirs = { '/home' }
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
               path_display = { "tail" },
               disable_coordinates = true
            }
         end

         -- Custom telescope mode that presents a list of nvim
         -- configuration files.
         local nvim_modules = function()
            builtin.find_files {
               search_dirs = { '$HOME/.config/nvim/' },
               path_display = { "smart" },
               prompt_title = "Nvim modules",
               hidden = false,
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
               path_display = { "truncate" },
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
            },
         }

         -- tele.load_extension('fzf')
         tele.load_extension('file_browser')
         tele.load_extension('ui-select')

         vim.keymap.set('n', '<leader>f/', builtin.current_buffer_fuzzy_find)
         vim.keymap.set('n', '<leader>fH', builtin.highlights)
         vim.keymap.set('n', '<leader>fb', builtin.buffers)
         vim.keymap.set('n', '<leader>fc', builtin.colorscheme)
         vim.keymap.set('n', '<leader>ff', builtin.find_files)
         vim.keymap.set('n', '<leader>fh', builtin.help_tags)
         vim.keymap.set('n', '<leader>fj', builtin.jumplist)
         vim.keymap.set('n', '<leader>fk', builtin.keymaps)
         vim.keymap.set('n', '<leader>fl', grep_in_open_buffers)
         vim.keymap.set('n', '<leader>fm', nvim_modules)
         vim.keymap.set('n', '<leader>ft', builtin.treesitter) -- various symbols
         vim.keymap.set('n', '<leader>fn', browse_notes)
         vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
         vim.keymap.set('n', '<leader>fr', find_files_from_root)
         vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols)
         vim.keymap.set('n', '<leader>fv', builtin.vim_options)
      end,
   }
}

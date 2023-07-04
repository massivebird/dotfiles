return {

   -- {
   --    'ntpeters/vim-better-whitespace',
   --    config = function()
   --       vim.g['current_line_whitespace_disabled_hard'] = 1
   --       vim.g['better_whitespace_guicolor'] = '#ff5555'
   --       vim.g['better_whitespace_filetypes_blacklist'] = {
   --          '', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive'
   --       }
   --    end
   -- },

   -- default options
   -- "tpope/vim-sensible",

   -- comment stuff out
   "tpope/vim-commentary",

   -- git commands like :G and :g?
   "tpope/vim-fugitive",

   -- parentheses/tags/brackets editing
   "tpope/vim-surround",

   -- search/substitute/abbreviate words
   "tpope/vim-abolish",

   -- repeat supported plugin actions with . key
   "tpope/vim-repeat",

   -- autocomplete braces and scopes
   "jiangmiao/auto-pairs",

   -- close buffer without closing window with :Bdelete
   "moll/vim-bbye",

   -- align regions of text w :Tab[ular]
   {
      "godlygeek/tabular",
   },

   -- indent guides
   {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
         require('indent_blankline').setup {
            -- show_current_context = true,
            -- show_current_context_start = true,
            -- char = "|",
            show_end_of_line = false,
         }
      end
   },

   -- transforming between single- and multi-line statements
   "andrewradev/splitjoin.vim",

}

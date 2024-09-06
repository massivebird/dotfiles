return {

   -- {
   --    'ntpeters/vim-better-whitespace',
   --    config = function()
   --       vim.g['current_line_whitespace_disabled_hard'] = 1
   --       vim.g['better_whitespace_guicolor'] = '#ff5555'
   --       vim.g['better_whitespace_filetypes_blacklist'] = {
   --          '', 'diff', 'git', 'gitcommit', 'unite',
   --          'qf', 'help', 'fugitive'
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
      main = "ibl",
      config = function()
         require("ibl").setup {
            enabled = true,
            scope = {
               enabled = false,
            },
         }
      end
   },

   -- transforming between single- and multi-line statements
   "andrewradev/splitjoin.vim",

   {
      -- color-coded parentheses and stuff
      'hiphish/rainbow-delimiters.nvim',
      ft = {
         "c",
         "clojure",
         "cpp",
         "javascript",
         "json",
         "lua",
         "python",
         "rust",
         "typescript",
      }
   },

   {
      -- help doc decorations
      "OXY2DEV/helpview.nvim",
      lazy = false, -- false is recommended
      enabled = false, -- broken (for me) (for now) ;_;
      dependencies = {
         "nvim-treesitter/nvim-treesitter"
      },
   },
}

return {
   {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      event = {"BufReadPost", "BufNewFile"},
      opts = {
         ensure_installed = {
            "bash",
            "c",
            "clojure",
            "cpp",
            "css",
            "fish",
            "html",
            "javascript",
            "json",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "php",
            "python",
            "regex",
            "rust",
            "vim",
            "vimdoc",
         },
         auto_install = true,
         ignore_install = {},
         indent = { enable = true },
         highlight = {
            enable = true,
            disable = {
               "vim",
               "html",
               "php",
               "gitcommit"
            },
            additional_vim_regex_highlighting = true,
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
      },
      dependencies = {

         -- color-coded parentheses and stuff
         { 'p00f/nvim-ts-rainbow' },

         {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
               enable = true,
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
         },

      }
   }
}

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
            "java",
            "javascript",
            "json",
            "kotlin",
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
            disable = { "jsx", "cpp", "html", "php"},
            query = "rainbow-parens",
            -- strategy = require("ts-rainbow").strategy.global,
         },
      },
      dependencies = {

         -- color-coded parentheses and stuff
         'hiphish/nvim-ts-rainbow2',

         {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
               enable = true,
               max_lines = 1,
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

      },
      config = function(_, opts)
         if type(opts.ensure_installed) == "table" then
            ---@type table<string, boolean>
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
               if added[lang] then
                  return false
               end
               added[lang] = true
               return true
            end, opts.ensure_installed)
         end
         require("nvim-treesitter.configs").setup(opts)
      end,
   }

}

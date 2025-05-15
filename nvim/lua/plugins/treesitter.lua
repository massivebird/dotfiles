return {

   {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      event = { "BufReadPost", "BufNewFile" },
      opts = {
         ensure_installed = {
            "bash",
            "css",
            "html",
            "javascript",
            "json",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "regex",
            "rust",
            "vim",
            "vimdoc",
         },

         -- Install missing parsers when entering a buffer.
         auto_install = true,

         -- Do not install these parsers.
         ignore_install = {},

         -- Indent with `=`.
         indent = { enable = true },

         -- Syntax highlighting.
         highlight = {
            enable = true,
            disable = {
               "gitcommit",
               "html",
               "markdown",
               "php",
               "vim",
            },
            additional_vim_regex_highlighting = false,
         },

         -- Selection based on grammar nodes.
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
      },

      dependencies = {
         {
            -- auto-[close|rename] html tags
            'windwp/nvim-ts-autotag',
            lazy = true,
            ft = "html",
            opts = {},
         },

         {
            -- pin contextual lines at the top of the buffer
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
               mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
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

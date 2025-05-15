return {

   {
      "nvim-lualine/lualine.nvim",

      init = function()
         -- Refresh statusline when the cursor moves. Fixed some lag in newer versions.
         -- See: #792
         vim.api.nvim_create_autocmd('CursorMoved', { callback = require('lualine').refresh })
      end,

      dependencies = { { 'nvim-tree/nvim-web-devicons', lazy = true } },

      opts = function()
         return {
            options = {
               icons_enabled = true,

               color = 'Folded',
               theme = 'auto',

               component_separators = { left = '', right = '' },
               section_separators = { left = '', right = '' },
               disabled_filetypes = {
                  statusline = {},
                  winbar = {},
               },

               -- Always draw inactive statusline for listed filetypes
               ignore_focus = { "" },

               -- Limits {abc} and {xyz} section widths.
               always_divide_middle = true,

               -- One statusline for all windows.
               globalstatus = true,

               refresh = {
                  statusline = 1000,
                  tabline = 1000,
                  winbar = 1000,
               },
            },

            sections = {
               -- Left half

               lualine_a = {},

               lualine_b = { 'filename' },

               lualine_c = {
                  {
                     'diff',
                     color = 'Folded',
                     symbols = { added = " ", removed = " ", modified = " " }
                  },
               },

               -- Right half

               lualine_x = {
                  {
                     'branch',
                     color = 'Folded',
                     icon = ""
                  },
                  {
                     'diagnostics',
                     color = 'Folded',
                     symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " }
                  },
               },

               lualine_y = {
                  {
                     'progress',
                     color = 'Folded',
                  },
               },

               lualine_z = {
                  {
                     'location',
                     color = 'Folded',
                  },
               }
            },

            inactive_sections = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = { 'filename' },
               lualine_x = { 'location' },
               lualine_y = {},
               lualine_z = {}
            },

            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}

         }
      end
   },

}

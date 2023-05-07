return {

   {
      "nvim-lualine/lualine.nvim",
      dependencies = {
         { 'nvim-tree/nvim-web-devicons', opt = true }
      },
      opts = function()
         return {

            options = {
               icons_enabled = true,
               color = 'Folded',
               theme = 'auto',
               component_separators = { left = '', right = ''},
               section_separators = { left = '', right = ''},
               disabled_filetypes = {
                  statusline = {},
                  winbar = {},
               },

               ignore_focus = {},
               always_divide_middle = true,
               globalstatus = true,
               refresh = {
                  statusline = 1000,
                  tabline = 1000,
                  winbar = 1000,
               },
            },

            sections = {

               lualine_a = {},

               lualine_b = {},

               lualine_c = {

                  {
                     'filename',
                  },

               },

               lualine_x = {
                  {
                     'branch',
                     color = 'Folded',
                  },
                  {
                     'diff',
                     color = 'Folded',
                  },
                  {
                     'diagnostics',
                     color = 'Folded',
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
               lualine_c = {'filename'},
               lualine_x = {'location'},
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

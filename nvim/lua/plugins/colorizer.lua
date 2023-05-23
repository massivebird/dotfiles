return {

   {
      "nvchad/nvim-colorizer.lua",
      config = function()
         -- https://github.com/NvChad/nvim-colorizer.lua#Customization
         require("colorizer").setup {
            user_default_options = {
               -- update even when buffer is not focused
               always_update = true,
               -- "red, "blue"
               names = false,
               -- #123, #A23
               RGB = false,
               -- 0x221100ff
               AARRGGBB = true,
               -- #00FF0020
               RRGGBBAA = true,
            }
         }
      end,
   },

}

return {

   {
      "nvchad/nvim-colorizer.lua",
      config = function()
         -- https://github.com/NvChad/nvim-colorizer.lua#Customization
         require("colorizer").setup {
            user_default_options = {
               always_update = true,
               names = false,
            }
         }
      end,
   },

}

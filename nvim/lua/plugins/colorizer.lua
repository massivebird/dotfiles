return {

   {
      "nvchad/nvim-colorizer.lua",
      opts = { -- https://github.com/NvChad/nvim-colorizer.lua#Customization
         user_default_options = {
            -- Update even when buffer is not focused.
            always_update = true,

            -- ex: "red, "blue"
            names = false,

            -- ex: #123, #A23
            RGB = false,

            -- ex: 0x221100ff
            AARRGGBB = true,

            -- ex: #00FF0020
            RRGGBBAA = true,
         }
      }
   },

}

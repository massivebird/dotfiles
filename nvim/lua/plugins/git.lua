return {

   "https://github.com/lewis6991/gitsigns.nvim",
   config = function()
      local gs = require("gitsigns")

      gs.setup {
         signs = {
            auto_attach = true,
         }
      }

      vim.keymap.set('n', '<leader>gn', gs.next_hunk, { silent = true })
      vim.keymap.set('n', '<leader>gp', gs.prev_hunk, { silent = true })
      vim.keymap.set('n', '<leader>gv', gs.preview_hunk, { silent = true })
      vim.keymap.set('n', '<leader>gu', gs.reset_hunk, { silent = true })
   end

}

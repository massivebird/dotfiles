return {

   {
      "preservim/vim-markdown",
      ft = { "markdown" },
      config = function()
         vim.opt.conceallevel = 0
         -- vim.g["vim_markdown_folding_disabled"] = 0
         -- vim.g["vim_markdown_folding_level"] = 3
         vim.g["vim_markdown_new_list_item_indent"] = 2
      end
   },

   -- preview in web browser
   {
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      build = "cd app && npm install",
      init = function()
         vim.g.mkdp_filetypes = { "markdown" }
      end,
   },

}

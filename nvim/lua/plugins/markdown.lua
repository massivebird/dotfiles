return {


   {
      -- Header highlights, code block syntax highlighting, etc.
      "preservim/vim-markdown",
      ft = { "markdown" },
      config = function()
         vim.opt.conceallevel = 0

         -- Prevent folding the entire freaking document
         vim.g["vim_markdown_folding_level"] = 3

         -- Number of spaces per list indent level
         vim.g["vim_markdown_new_list_item_indent"] = 2

         -- Disable plugin keymaps (their `gx` override sucks)
         vim.g["vim_markdown_no_default_key_mappings"] = 1

         -- Enable pseudo LaTeX syntax highlighting, as in $x^2$
         vim.g["vim_markdown_math"] = 1

         -- Enable pseudo frontmatter syntax highlighting
         vim.g["vim_markdown_frontmatter"] = 1
         vim.g["vim_markdown_toml_frontmatter"] = 1

         -- Enable strikethrough styling
         vim.g["vim_markdown_strikethrough"] = 1
      end
   },

   -- Preview markdown in web browser
   {
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      build = "cd app && npm install && cd - && git restore .",
      -- ^^ yeah this never worked for me lmao
      -- run `npm install` in the plugin directory
      -- then in neovim do `:call mkdp#util#install()`
      init = function()
         vim.g.mkdp_filetypes = { "markdown" }
      end,
   },

}

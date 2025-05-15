return {

   {
      "airblade/vim-gitgutter",
      config = function()
         vim.keymap.set('n', '<leader>gn', ':GitGutterNextHunk<cr>', { silent = true })
         vim.keymap.set('n', '<leader>gp', ':GitGutterPrevHunk<cr>', { silent = true })
         vim.keymap.set('n', '<leader>gv', ':GitGutterPreviewHunk<cr>', { silent = true })
         vim.keymap.set('n', '<leader>gu', ':GitGutterUndoHunk<cr>', { silent = true })
      end
   },

}

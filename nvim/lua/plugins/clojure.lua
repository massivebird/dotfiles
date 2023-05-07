return {

   {
      'olical/conjure',
      config = function()
         vim.g['conjure#filetypes'] = {"clojure"}
         vim.g['conjure#mapping#doc-word'] = false
         vim.g.ale_linters = {
            ['*'] = {'ale_linters'},
            ['clojure'] = {'clj-kondo'},
            ['lua'] = {'luacheck'}
         }
      end
   },

   { 'tpope/vim-dispatch' },

   { 'tpope/vim-fireplace' },

   { 'clojure-vim/vim-jack-in' },

   { 'radenling/vim-dispatch-neovim' },

}

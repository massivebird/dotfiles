-- space bar as leader
vim.g.mapleader = ' '

-- package manager: folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

-- var set prior to loading plugins that depend on it
vim.cmd 'let base16colorspace = 256'
if vim.fn.has("termguicolors") then
   vim.opt.termguicolors = true
end

require("lazy").setup("plugins", {
   install = {
      -- native fallback colorscheme
      colorscheme = { "koehler" },
   },
   ui = {
      border = "rounded",
   },
   change_detection = {
      enabled = true,
      notify = false,
   },
})

require("general")
require("logic")
require("keymaps")

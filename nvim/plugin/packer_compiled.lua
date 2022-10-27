-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/penguino/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/penguino/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/penguino/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/penguino/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/penguino/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["awesome-vim-colorschemes"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/awesome-vim-colorschemes",
    url = "https://github.com/rafi/awesome-vim-colorschemes"
  },
  ["coc.nvim"] = {
    config = { "\27LJ\2\n_\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\n<c-k>\21coc_snippet_prev\n<c-j>\21coc_snippet_next\6g\bvim\0" },
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  conjure = {
    config = { "\27LJ\2\nN\0\0\3\0\6\0\a6\0\0\0009\0\1\0005\1\4\0005\2\3\0=\2\5\1=\1\2\0K\0\1\0\fclojure\1\0\0\1\2\0\0\14clj-kondo\16ale_linters\6g\bvim\0" },
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/conjure",
    url = "https://github.com/olical/conjure"
  },
  ["estilo-xoria256"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/estilo-xoria256",
    url = "https://github.com/neozenith/estilo-xoria256"
  },
  ["galaxian-vim"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/galaxian-vim",
    url = "https://github.com/evprkr/galaxian-vim"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/lightline.vim",
    url = "https://github.com/itchyny/lightline.vim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n“\3\0\0\5\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0005\4\n\0=\4\v\3=\3\f\0025\3\r\0005\4\14\0=\4\v\3=\3\15\2B\0\2\1K\0\1\0\frainbow\1\5\0\0\bjsx\bcpp\thtml\bphp\1\0\2\18extended_mode\2\venable\2\14highlight\fdisable\1\5\0\0\bvim\rmarkdown\thtml\bphp\1\0\2&additional_vim_regex_highlighting\2\venable\2\vindent\1\0\1\venable\2\19ignore_install\21ensure_installed\1\0\1\17auto_install\2\1\f\0\0\6c\bphp\vpython\fclojure\trust\thtml\bcss\rmarkdown\bvim\tfish\tjson\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["tokyonight-vim"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/tokyonight-vim",
    url = "https://github.com/ghifarit53/tokyonight-vim"
  },
  ultisnips = {
    config = { "\27LJ\2\në\1\0\0\2\0\t\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\5\0=\1\6\0006\0\0\0009\0\1\0'\1\5\0=\1\a\0006\0\0\0009\0\1\0'\1\5\0=\1\b\0K\0\1\0!UltiSnipsJumpBackwardTrigger UltiSnipsJumpForwardTrigger\26UltiSnipsListSnippets\n<Nop>\27UltiSnipsExpandTrigger\15horizontal\23UltiSnipsEditSplit\6g\bvim\0" },
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/sirver/ultisnips"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-css-color"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-css-color",
    url = "https://github.com/ap/vim-css-color"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim",
    url = "https://github.com/radenling/vim-dispatch-neovim"
  },
  ["vim-fireplace"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-fireplace",
    url = "https://github.com/tpope/vim-fireplace"
  },
  ["vim-framer-syntax"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-framer-syntax",
    url = "https://github.com/massivebird/vim-framer-syntax"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-hexokinase",
    url = "https://github.com/rrethy/vim-hexokinase"
  },
  ["vim-jack-in"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-jack-in",
    url = "https://github.com/clojure-vim/vim-jack-in"
  },
  ["vim-markdown"] = {
    config = { '\27LJ\2\n‡\1\0\0\2\0\6\0\f6\0\0\0)\1\2\0=\1\1\0006\0\2\0009\0\3\0)\1\0\0=\1\4\0006\0\2\0009\0\3\0)\1\3\0=\1\5\0K\0\1\0\31vim_markdown_folding_level"vim_markdown_folding_disabled\6g\bvim\17conceallevel\bset\0' },
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-obsession",
    url = "https://github.com/tpope/vim-obsession"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-sensible",
    url = "https://github.com/tpope/vim-sensible"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/penguino/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: coc.nvim
time([[Config for coc.nvim]], true)
try_loadstring("\27LJ\2\n_\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\n<c-k>\21coc_snippet_prev\n<c-j>\21coc_snippet_next\6g\bvim\0", "config", "coc.nvim")
time([[Config for coc.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n“\3\0\0\5\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0005\4\n\0=\4\v\3=\3\f\0025\3\r\0005\4\14\0=\4\v\3=\3\15\2B\0\2\1K\0\1\0\frainbow\1\5\0\0\bjsx\bcpp\thtml\bphp\1\0\2\18extended_mode\2\venable\2\14highlight\fdisable\1\5\0\0\bvim\rmarkdown\thtml\bphp\1\0\2&additional_vim_regex_highlighting\2\venable\2\vindent\1\0\1\venable\2\19ignore_install\21ensure_installed\1\0\1\17auto_install\2\1\f\0\0\6c\bphp\vpython\fclojure\trust\thtml\bcss\rmarkdown\bvim\tfish\tjson\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-markdown
time([[Config for vim-markdown]], true)
try_loadstring('\27LJ\2\n‡\1\0\0\2\0\6\0\f6\0\0\0)\1\2\0=\1\1\0006\0\2\0009\0\3\0)\1\0\0=\1\4\0006\0\2\0009\0\3\0)\1\3\0=\1\5\0K\0\1\0\31vim_markdown_folding_level"vim_markdown_folding_disabled\6g\bvim\17conceallevel\bset\0', "config", "vim-markdown")
time([[Config for vim-markdown]], false)
-- Config for: conjure
time([[Config for conjure]], true)
try_loadstring("\27LJ\2\nN\0\0\3\0\6\0\a6\0\0\0009\0\1\0005\1\4\0005\2\3\0=\2\5\1=\1\2\0K\0\1\0\fclojure\1\0\0\1\2\0\0\14clj-kondo\16ale_linters\6g\bvim\0", "config", "conjure")
time([[Config for conjure]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\2\në\1\0\0\2\0\t\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\5\0=\1\6\0006\0\0\0009\0\1\0'\1\5\0=\1\a\0006\0\0\0009\0\1\0'\1\5\0=\1\b\0K\0\1\0!UltiSnipsJumpBackwardTrigger UltiSnipsJumpForwardTrigger\26UltiSnipsListSnippets\n<Nop>\27UltiSnipsExpandTrigger\15horizontal\23UltiSnipsEditSplit\6g\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

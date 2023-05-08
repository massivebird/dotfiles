local setkeymap = vim.keymap.set
local cmd = vim.cmd

-- saving and quitting
setkeymap('n', '<leader>w', ':w!<cr>', {silent = true})
setkeymap('n', '<leader>q', ':wq<cr>', {silent = true})
setkeymap('n', '<leader>Q', ':q!<cr>', {silent = true})

-- close window
setkeymap('n', '<leader>c', ':close<cr>', {silent = true})

-- rewrite entire document
setkeymap('n', 'cA', 'ggcG')

-- redo
setkeymap('n', 'U', '<C-r>')

-- reload configuration file(s)
setkeymap('n', '<leader>s', ':source ~/.config/nvim/init.lua<cr>', {silent = true})

-- packer commands
-- setkeymap('n', '<leader>pc', ':PackerCompile<cr>', {silent = true}) -- regen changed plugin config
-- setkeymap('n', '<leader>pi', ':PackerInstall<cr>', {silent = true}) -- clean, install missing
-- setkeymap('n', '<leader>ps', ':PackerSync<cr>', {silent = true})    -- update, compile
-- setkeymap('n', '<leader>pu', ':PackerUpdate<cr>', {silent = true})  -- clean, update

-- initiate terminal mode
setkeymap('n', '<leader>t', ':term<cr>', {silent = true})

-- exit terminal mode
setkeymap('t', '<Esc>', '<C-\\><C-n>')

-- stop highlighting text (useful after search/substitute)
setkeymap('n', '<leader>n', ':noh<cr>', {silent = true})

-- initiate global substitute
setkeymap('n', '<leader>S', ':%s//g<Left><Left>')

-- search defaults to case insensitive
setkeymap('n', '/', ':/\\c<Left><Left>')

-- searching in visual mode searches only selected area
setkeymap('v', '/', '<Esc>:/\\%V\\c<Left><Left>')

-- view registers
setkeymap('n', '<leader>r', ':registers<cr>', {silent = true})

-- buffer controls
setkeymap('n', '<leader>bn', ':bn<cr>', {silent = true})
setkeymap('n', '<leader>bp', ':bp<cr>', {silent = true})
setkeymap('n', '<leader>bd', ':Bdelete<cr>', {silent = true})

-- because it was doing strange things >:(
setkeymap('n', '<leader><Esc>', '<Nop>')

-- move line up/down
setkeymap('n', '<A-j>', ':m .+1<CR>==')
setkeymap('n', '<A-k>', ':m .-2<CR>==')
setkeymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
setkeymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
-- setkeymap('v', '<A-j>', ':m '>+1<CR>gv=gv')
-- setkeymap('v', '<A-k>', ':m '<-2<CR>gv=gv')

-- resize window
setkeymap('n', '<Up>',    ':resize +2<cr>', {silent = true})
setkeymap('n', '<Down>',  ':resize -2<cr>', {silent = true})
setkeymap('n', '<Right>', ':vertical resize +2<cr>', {silent = true})
setkeymap('n', '<Left>',  ':vertical resize -2<cr>', {silent = true})

-- create new line above or below current line
setkeymap('n', '<leader>o', 'o<Up><Esc>')
setkeymap('n', '<leader>O', 'O<Down><Esc>')

-- fix indentation of entire file
setkeymap('n', '<F7>', 'mZgg=G`Z')

-- toggle spelling
setkeymap('n', '<leader>d', ':set spell!<cr>')

-- conjure: evaluations
setkeymap('n', '<leader>e', ':%ConjureEval<cr>')
-- setkeymap('n', '<leader>f', ':ConjureEvalCurrentForm<cr>')

-- clojure: (1) Creates conjure log in right-hand window (2) launches REPL in new tab
setkeymap('n', '<leader>CL', ':ConjureLogVSplit<cr><C-w>L:tabnew<cr>:term<cr>ibash ~/.clojure/startserver.sh<Enter><C-\\><C-n>:tabprevious<cr><C-w>h')

-- navigate vimgrep ft. looping quickfix navigation
cmd [[
command! Cprev try | cprev | catch | clast | catch | endtry
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
]]

-- navigate quickfix list
setkeymap('n', '<C-p>',     ':Cnext<cr>', {silent = true})
setkeymap('n', '<C-o>',     ':Cprev<cr>', {silent = true})
setkeymap('n', '<leader>[', ':Ngrep ' )

-- get rid of weird location list error
setkeymap('n', '<esc>', '<nop>')

-- I HATE ex mode
setkeymap('n', 'Q', '<Nop>')
setkeymap('n', 'q:', ':')

-- place semicolon at end of current line
setkeymap('n', '<leader>;', 'mY:s/$/;<cr>:noh<cr>`Y', {silent = true})

-- open/close fold under cursor
setkeymap('n', 'zl', 'zA', {silent = true})
setkeymap('n', 'zh', 'zC', {silent = true})

-- Diagnostic keymaps
setkeymap('n', '[d', vim.diagnostic.goto_prev)
setkeymap('n', ']d', vim.diagnostic.goto_next)
-- setkeymap('n', '<leader>e', vim.diagnostic.open_float)
-- setkeymap('n', '<leader>q', vim.diagnostic.setloclist)

-- keymaps: Stel's navigation solutions ----------
-- github.com/stelcodes/xdg-config

-- move to tab by index
setkeymap('n', '<leader>1', '1gt')
setkeymap('n', '<leader>2', '2g <leader>3 3gt')
setkeymap('n', '<leader>4', '4g <leader>5 5gt')
setkeymap('n', '<leader>6', '6g <leader>7 7gt')
setkeymap('n', '<leader>8', '8g <leader>9 9gt')
setkeymap('n', '<leader>0', ':tablast<cr>')

-- tab moves cursor 10 lines down, shift-tab 10 lines up
setkeymap('n', '<tab>',   '10j')
setkeymap('n', '<s-tab>', '10k')

-- navigate windows in a way that actually makes sense
setkeymap('n', '<c-j>', '<C-w>j')
setkeymap('n', '<c-k>', '<C-w>k')
setkeymap('n', '<c-h>', '<c-w>h')
setkeymap('n', '<c-l>', '<c-w>l')

-- presentation mode
setkeymap('n', '<c-p>', ':set signcolumn=yes:9 showmode! relativenumber! number!<cr>:GitGutterDisable<cr>:CocDisable<cr>')

-- lazy.nvim window
setkeymap('n', '<leader>L', ':Lazy<cr>')

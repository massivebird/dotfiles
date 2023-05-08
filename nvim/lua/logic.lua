local cmd = vim.cmd

-- colorscheme switcher
local colorscheme_option = 0
if colorscheme_option == 0 then
   cmd 'colorscheme framer_syntax_dark'
elseif colorscheme_option == 1 then
   cmd 'colorscheme slate'
end

-- quick edit init.lua
cmd [[ command! Nc :e ~/.config/nvim/init.lua ]]

local file_exists = function(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- note-querying function
-- github.com/connermcd
cmd [[command! -nargs=1 Ngrep vimgrep "<args>\c" $NOTES_DIR/*/*/*.md]]

-- I never got this to work
-- fun! MyNgrep(query, ...)
-- let query = "/".a:query."/j"
-- let course = get(a:, 1, "")
-- let path = "$NOTES_DIR/" . course . "*/*/*.md"
-- if course == ""
--    let path = "$NOTES_DIR/*/*/*.md"
-- else
--    let path = "$NOTES_DIR/" . course . "*/*/*.md"
--    endif
--    echom query path
--    execute "vimgrep" query path bufname("#")
--    endfunction
--    command! -nargs=+ Ngrepg call MyNgrep(<f-args>)
--    command! -nargs=* Ngrepa vimgrep "<args>\c" $NOTES_DIR/*/*/*.md


-- identify highlight group under cursor
cmd [[
function! SynGroup()
let l:s = synID(line('.'), col('.'), 1)
echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
nnoremap <leader>hg :call SynGroup()<cr>
command! SynGroup call SynGroup()
]]

if file_exists('/usr/bin/python3.10') then
   -- laptop
   vim.g['python3_host_prog'] = '/usr/bin/python3.10'
else
   -- desktop
   vim.g['python3_host_prog'] = '/usr/bin/python3.8'
end

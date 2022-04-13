" Plugin Manager: vim-plug

let $VIM='~/.config/nvim/init.vim'

call plug#begin('~/.config/nvim/plugged')

" Tim Pope aka Magic Hands
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'

" Hip status line
Plug 'itchyny/lightline.vim'

" Color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'evprkr/galaxian-vim'
Plug 'ap/vim-css-color'
Plug 'ghifarit53/tokyonight-vim'
Plug 'massivebird/vim-framer-syntax'
Plug 'massivebird/ibm-vim'

" Autocomplete braces and scopes
Plug 'jiangmiao/auto-pairs'

" Active version control feedback
Plug 'airblade/vim-gitgutter'

" Markdown support
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] } "req :call #mkdp#util#install()

" Clojure support
Plug 'olical/conjure'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'clojure-vim/vim-jack-in'
Plug 'radenling/vim-dispatch-neovim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'

" COC autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}

call plug#end()

""""""""""""""""""""""""""""""""""""""""""

" Terminalneous
" You ain't no nerd?? I coulda sworn you were.

colorscheme framer_syntax_dark
let g:lightline = {'colorscheme': 'framer_dark'}

syntax on
syntax enable
set wildmenu
set spelllang=en_us
set nospell
set cursorline
set number
set norelativenumber
set noshowmode
set shiftwidth=0
set splitright
set linebreak
autocmd TermOpen * setlocal nonumber norelativenumber
filetype plugin indent on

" gitgutter colors
highlight SignColumn guibg=bg
highlight GitGutterAdd guibg=bg
highlight GitGutterChange guibg=bg
highlight GitGutterDelete guibg=bg
let g:gitgutter_set_sign_backgrounds = 1

" Change someday to colorscheme
hi GitGutterAdd guifg=SeaGreen
hi GitGutterDelete guifg=Red
hi GitGutterChange guifg=LightGrey

" color nonsense
let base16colorspace = 256
if has("termguicolors")
	set termguicolors
endif

""""""""""""""""""""""""""""""""""""""""""

" Clojure

let g:ale_linters = { 'clojure': ['clj-kondo']}

""""""""""""""""""""""""""""""""""""""""""

" Python

let g:python3_host_prog = '/usr/bin/python3.8'

""""""""""""""""""""""""""""""""""""""""""

" Markdown

let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""

" Treesitter

lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
ignore_install = { "javascript" }, -- List of parsers to ignore installing
indent = {
enable = true
},
	highlight = {
	enable = true,              -- false will disable the whole extension
	disable = {"vim"},  -- list of language that will be disabled
	},
rainbow = {
enable = true,
disable = { "jsx", "cpp" }, -- list of languages you want to disable the plugin for
extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
max_file_lines = nil, -- Do not enable for files with more than n lines, int
-- colors = {}, -- table of hex strings
-- termcolors = {} -- table of colour name strings
},
}
EOF

""""""""""""""""""""""""""""""""""""""""""

" Notetaking tools courtesy of github.com/connermcd

command! -nargs=1 Ngrep vimgrep "<args>\c" $NOTES_DIR/*/*/*.md

" CURRENT ISSUE : 'Cannot open files' aka does not immediately show first
" result
fun! MyNgrep(query, ...)
	let query = "/".a:query."/j"
	let course = get(a:, 1, "")
	let path = "$NOTES_DIR/" . course . "*/*/*.md"
	if course == ""
		let path = "$NOTES_DIR/*/*/*.md"
	else
		let path = "$NOTES_DIR/" . course . "*/*/*.md"
	endif
	echom query path
	execute "vimgrep" query path bufname("#")
endfunction

command! -nargs=+ Ngrepg call MyNgrep(<f-args>)
command! -nargs=* Ngrepa vimgrep "<args>\c" $NOTES_DIR/*/*/*.md

""""""""""""""""""""""""""""""""""""""""""

" Stel's Stellar Remaps

" ctrl-[hjkl] moves window focus in that direction, moving to another tab
" if necessary
function! MoveLeft()
	if (winnr() == winnr('1h'))
		:tabprevious
	else
		:call nvim_input("<Esc><C-w>h")
	endif
endfunction

function! MoveRight()
	if (winnr() == winnr('1l'))
		:tabnext
	else
		:call nvim_input("<Esc><C-w>l")
	endif
endfunction

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> :call MoveLeft()<CR>
nnoremap <C-l> :call MoveRight()<CR>

inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-h> <Esc>:call MoveLeft()<CR>
inoremap <C-l> <Esc>:call MoveRight()<CR>

tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n>:call MoveLeft()<CR>
tnoremap <C-l> <C-\><C-n>:call MoveRight()<CR>
nnoremap <C-l> <C-\><C-n>:call MoveRight()<CR>

" Move to tab by index
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" tab moves cursor 10 lines down, shift-tab 10 lines up
nnoremap <silent> <TAB> 10j
nnoremap <silent> <S-TAB> 10k

" move through wrapped lines visually
nnoremap j gj
nnoremap k gk

""""""""""""""""""""""""""""""""""""""""""

" Garrett's Great Remaps

" Space bar as leader
let mapleader = " "

" Essentials
nnoremap <leader>w	:w<cr>
nnoremap <leader>q	:wq<cr>
nnoremap <leader>Q	:q!<cr>
nnoremap <leader>c	:close<cr>
nnoremap <leader>A	ggcG
nnoremap <leader>s	:source ~/.config/nvim/init.vim<cr>
nnoremap <leader>pi	:PlugInstall<cr>
nnoremap <leader>pc	:PlugClean<cr>
nnoremap <leader>pu	:PlugUpdate<cr>
nnoremap <leader>t	:term<cr>
nnoremap <leader>n	:noh<cr>
nnoremap <leader>S	:%s//g<Left><Left>
nnoremap /           :/\c<Left><Left>

" Redo
nnoremap U <C-r>

" Escape exits terminal mode
tnoremap <Esc> <C-\><C-n>

" Because it was doing strange things >:(
nnoremap <leader><Esc> <Nop>

" Move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" Window resizing
nnoremap <Up>		:resize +2<cr>
nnoremap <Down>		:resize -2<cr>
nnoremap <Right>	:vertical resize +2<cr>
nnoremap <Left>		:vertical resize -2<cr>

" Create new line above or below current line
nnoremap <leader>o o<Up><Esc>
nnoremap <leader>O O<Down><Esc>

" Fix indentation of entire file (deprecated soon probably)
nnoremap <F7> gg=G<C-o><C-o><C-o>

" \"Docs\" mode
nnoremap <leader>d :set spell<cr> :set wrap<cr>

" Conjure evaluations
nnoremap <leader>e :%ConjureEval<cr>
nnoremap <leader>f :ConjureEvalCurrentForm<cr>

" Clojure: (1) Creates conjure log in right-hand window (2) launches REPL in new tab
nnoremap <leader>CL :ConjureLogVSplit<cr><C-w>L:tabnew<cr>:term<cr>ibash ~/.clojure/startserver.sh<Enter><C-\><C-n>:tabprevious<cr><C-w>h

" Vimgrep navigation ft. looping quickfix navigation
command! Cprev try | cprev | catch | clast | catch | endtry
command! Cnext try | cnext | catch | cfirst | catch | endtry

command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

" Quickfix list nav remaps
nnoremap <C-p>		:Cnext<cr>
nnoremap <C-o>		:Cprev<cr>
nnoremap <leader>[	:Ngrep 

" Get rid of weird location list error
nnoremap <Esc> <Nop>

" Plugin Manager: vim-plug

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
Plug 'balanceiskey/vim-framer-syntax', { 'branch': 'main'  }

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
Plug 'clojure-vim/vim-jack-in'
Plug 'radenling/vim-dispatch-neovim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'

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
" No, it doesn't indent very well

lua <<EOF
require'nvim-treesitter.configs'.setup {
	rainbow = {
	enable = true,
	-- disable = { "jsx", "cpp"  }, list of languages you want to disable the plugin for
	extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	max_file_lines = nil, -- Do not enable for files with more than n lines, int
	-- colors = {}, -- table of hex strings
	-- termcolors = {} -- table of colour name strings
	},
}
EOF

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
nnoremap <leader>s	:source ~/.config/nvim/init.vim<cr>
nnoremap <leader>pi	:PlugInstall<cr>
nnoremap <leader>pc	:PlugClean<cr>
nnoremap <leader>pu	:PlugUpdate<cr>
nnoremap <leader>t	:term<cr>
nnoremap <leader>A	ggcG
nnoremap <leader>n	:noh<cr>

" Window resizing
nnoremap <Up>		:resize +2<cr>
nnoremap <Down>		:resize -2<cr>
nnoremap <Right>	:vertical resize +2<cr>
nnoremap <Left>		:vertical resize -2<cr>

" Escape exits -- TERMINAL --
tnoremap <Esc> <C-\><C-n>

" Create new line above or below current line
nnoremap <leader>o o<Up><Esc>
nnoremap <leader>O O<Down><Esc>

" Redo
nnoremap U <C-r>

" Fix indentation of entire file (deprecated soon probably)
nnoremap <F7> gg=G<C-o><C-o><C-o>

" \"Docs\" mode
nnoremap <leader>d :set spell<cr> :set wrap<cr> :set linebreak<cr>

" Temporary clojure eval solution
nnoremap <leader>e :%ConjureEval<cr>

" Clojure: (1) Creates log in right-hand window (2) launches REPL in new tab
nnoremap <leader>CL :ConjureLogVSplit<cr><C-w>L:tabnew<cr>:term<cr>ibash ~/.clojure/startserver.sh<Enter><C-\><C-n>:tabprevious<cr><C-w>h

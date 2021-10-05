" Plugin Manager: vim-plug

call plug#begin('~/.config/nvim/plugged')

" Tim Pope aka Magic Hands
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'

Plug 'airblade/vim-gitgutter'

" Auto-close braces and scopes
Plug 'jiangmiao/auto-pairs'

" Interactive tree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }

" Airline status bar + themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'evprkr/galaxian-vim'

" Color previews
Plug 'ap/vim-css-color'

" Code formatting
Plug 'sbdchd/neoformat'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

""""""""""""""""""""""""""""""""""""""""""

" Terminalneous
" You ain't no nerd?? I coulda sworn you were.

colorscheme galaxian
syntax on
syntax enable
set spelllang=en
set nospell
set cursorline
set number
set norelativenumber
autocmd TermOpen * setlocal nonumber norelativenumber

" gitgutter colors
highlight SignColumn guibg=bg
highlight GitGutterAdd guibg=bg
" let g:gitgutter_set_sign_backgrounds = 1
" let g:gitgutter_sign_added = 'xx'
" let g:gitgutter_sign_modified = 'pp'
" let g:gitgutter_sign_removed = 'zz'
" let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_removed_above_and_below = '{'
" let g:gitgutter_sign_modified_removed = 'ww'

" Change someday to colorscheme
highlight GitGutterAdd guifg=SeaGreen 

" color nonsense
let base16colorspace = 256
if has("termguicolors")
	set termguicolors
endif

""""""""""""""""""""""""""""""""""""""""""

" Airline shit

" Smarter tab line
let g:airline#extensions#tabline#enabled = 0

let g:airline_powerline_fonts = 1

let g:airline_theme='murmur'

let g:airline_section_b="%t%m"

let g:airline_section_c="%f"

let g:airline_section_x=""

let g:airline_section_z=""

tnoremap <Esc> <C-\><C-n>

""""""""""""""""""""""""""""""""""""""""""

" no idea lol

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""

" Python

let g:python3_host_prog = '/usr/bin/python3.8'

""""""""""""""""""""""""""""""""""""""""""

" Stel's original window navigation solution

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

" Custom remaps

" Space bar as leader
let mapleader = " " " map leader to Space

" Essential commands
nnoremap <leader>w :w<cr>
nnoremap <leader>q :wq<cr>
nnoremap <leader>c :close<cr>
nnoremap <leader>s :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pc :PlugClean<cr>

" Escape exits -- TERMINAL --
tnoremap <Esc> <C-\><C-n>

" Create new line above or below current line
nnoremap <leader>o O<Down><Esc>
nnoremap <leader>O o<Up><Esc>

" Redo
nnoremap U <C-r>

" Fix indentation of entire file (deprecated soon probably)
nnoremap <F7> gg=G<C-o><C-o>

" \"Docs\" mode
nnoremap <leader>d :set spell<cr>

set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

set updatetime=250

syntax on
colorscheme dracula
set background=dark

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

set scrolloff=5
set sidescrolloff=5

set noerrorbells
set confirm
set hlsearch
set incsearch
set wildignore=*.o,*.class,*.pyc

set spelllang=en_gb
autocmd BufNewFile,BufRead *.tex setlocal spell
autocmd BufNewFile,BufRead *.md setlocal spell

autocmd BufNewFile,BufRead *.md set filetype=markdown

autocmd FileType make setlocal noexpandtab

set list!
set listchars=tab:»·

inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

set undofile
set undodir=$HOME/.vim/undo

set number

let $FZF_DEFAULT_COMMAND = 'rg --files'

let mapleader=","
nmap <silent> <leader>t :Files<cr>
nmap <silent> <leader>r :Tags<cr>
nmap <silent> <leader>c :nohlsearch<cr>

autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Use vim settings (not vi)
set nocompatible

" Required for vundle
filetype off

" Add vundle to the run-time path
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'tpope/vim-sensible'
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'danro/rename.vim'
Plugin 'scrooloose/nerdtree'
call vundle#end()

" Turn on syntax highlighting
syntax enable

" File type based indentation
filetype plugin indent on

" Number of spaces for a tab
set tabstop=4

" Number of spaces when using << or >>
set shiftwidth=4

" Insert spaces instead of tabs
set expandtab

" Always show 5 lines above / below the current line
set scrolloff=5

" Always show 5 characters to the left / right
set sidescrolloff=5

" When opening a file always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

" No beeps
set noerrorbells

" Ask for confirmation
set confirm

" Highlight the current line
set cursorline

" Highlight search results
set hlsearch

" Show line numbers
set number

" Ignore these files when expanding
set wildignore=*.o,*.class,*.pyc

" Spell-checking
set spelllang=en_gb
autocmd BufNewFile,BufRead *.tex setlocal spell
autocmd BufNewFile,BufRead *.md setlocal spell

" Markdown
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Use tabs in Makefiles
autocmd FileType make setlocal noexpandtab

" Show whitespace
set list!
set listchars=tab:»·

" Make cursor move as expected with wrapped lines
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo

" Key bindings
let mapleader=","
noremap <Leader>n :NERDTreeToggle<cr>

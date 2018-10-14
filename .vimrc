" if vim-plug is not downloaded, download it
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" all vim-plug plugins
call plug#begin('~/.vim/plugged')
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
call plug#end()

" make background the same as iterm2 background
set termguicolors

" use syntax highlighting
syntax enable

" use atom's one-dark theme
set background=dark
colorscheme one

" make vim more useful
set nocompatible

" use OS clipboard
set clipboard=unnamed
" cursor in insert mode
set esckeys
" backspace in insert mode
set backspace=indent,eol,start
" fast terminal connections
set ttyfast
" g flag with search as default
set gdefault

" centralize backups and swaps
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" enable line numbers
set number
" tab should have the length of four spaces
set softtabstop=4 noexpandtab
set shiftwidth=4
" highlight all search results
set hlsearch
" ignore cases of search
set ignorecase
" highlight dynamically
set incsearch
" always show statusbar
set laststatus=2
" enable mouse in all modes
set mouse=a
" no error bells
set noerrorbells
" don't reset cursor to start of line
set nostartofline
" cursor position
set ruler
" dont show intro message
set shortmess=atI
" titlename in window titlebar
set title
" relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" highlight matching brackets
set showmatch

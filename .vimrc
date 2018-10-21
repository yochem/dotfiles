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
Plug 'mityu/vim-applescript'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()

"""""""""""""""""""""""
"""""""" LOOK """""""""
"""""""""""""""""""""""
" make background the same as iterm2 background
set termguicolors

" use syntax highlighting
syntax enable

" use atom's one-dark theme
set background=dark
colorscheme one

" make vim more useful
set nocompatible

" always show statusbar
set laststatus=2

" dont show intro message
set shortmess=atI

" titlename in window titlebar
set title

" highlight matching brackets
set showmatch


"""""""""""""""""""""""
"""""" INDENTION """"""
"""""""""""""""""""""""
" auto indent
set autoindent

" tab should have the length of four spaces
set tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab

" don't reset cursor to start of line
set nostartofline


"""""""""""""""""""""""
"""""""" LINES """"""""
"""""""""""""""""""""""
" enable line numbers
set number
" cursor position
set ruler
" relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3


"""""""""""""""""""""""
"""""" SEARCHING """"""
"""""""""""""""""""""""
" g flag with search as default
set gdefault
"highlight all search results
set hlsearch
" ignore cases of search
set ignorecase
" highlight dynamically
set incsearch


"""""""""""""""""""""""
"""" RANDOM STUFF """""
"""""""""""""""""""""""
" use OS clipboard
set clipboard=unnamed

" cursor in insert mode
set esckeys

" backspace in insert mode
set backspace=indent,eol,start

" fast terminal connections
set ttyfast

" centralize backups and swaps
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" enable mouse in all modes
set mouse=a

" no error bells
set noerrorbells

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

inoremap ` <ESC>

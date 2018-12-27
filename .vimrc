"""""""""""""""""""""""
"""""" PLUGINS """"""""
"""""""""""""""""""""""
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
Plug 'gabrielelana/vim-markdown'
Plug 'rkulla/pydiction'
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
set shortmess=WIF

" dont care about spelling
set nospell
let g:markdown_enable_spell_checking = 0

" don't show 'Thanks for flying Vim'
set notitle

" split normal
set splitright
set splitbelow

" i really hate folding
set nofoldenable

" atom-like line to show where the 80 char bound is
set colorcolumn=80

" clear command output everytime when running
set shell=~/.vim/clear_shell.sh

"""""""""""""""""""""""
"""""" INDENTION """"""
"""""""""""""""""""""""
" auto indent
set autoindent

" tab should have the length of four spaces
set tabstop=8 softtabstop=4 shiftwidth=4 noexpandtab

" don't reset cursor to start of line
set nostartofline


"""""""""""""""""""""""
"""""""" LINES """"""""
"""""""""""""""""""""""
" enable line numbers
set number

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" add empty line without leaving normal mode
set timeoutlen=250
nmap oo m`o<Esc>``
nmap OO m`O<Esc>``

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
" enable filetype for plugins
filetype plugin on
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'

" set leader key
let mapleader = ','

" use OS clipboard
set clipboard=unnamed

" replace more characters at once in visual mode
vmap r "_dP

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

" autosave when 'running' the file
set autowrite

" no error bells
set noerrorbells

" Automatic commands
if has("autocmd")
    " go to last position when opening file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\"" | endif

    " Enable file type detection
    filetype on

    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

    " and .tex files as LaTeX
    autocmd BufRead,BufNewFile *.tex set filetype=tex

    " start on top and in insertmode with commits
    autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
    autocmd FileType gitcommit startinsert
endif

" remap ff as escape key for easier mode switching
inoremap ff <ESC>

" compile LaTeX quick
nmap <leader>r :!compile %<CR>

" tbh I copied this so idk what's going on
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           " buffer number
set statusline+=%#Visual#       " colour
set statusline+=%#CursorIM#     " colour
set statusline+=%#Cursor#       " colour
set statusline+=%#CursorLine#   " colour
set statusline+=\ %F\           " short file name
set statusline+=%m              " modified [+] flag
set statusline+=%=              " right align
set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\           " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\     " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\        " percentage


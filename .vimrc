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

" when splitting vertical, do this to the right
set splitright

" i really hate folding
set nofoldenable

" atom-like line to show where the 80 char bound is
set colorcolumn=80

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

" autosave when 'running' the file
set autowrite

" no error bells
set noerrorbells

" go to last position when opening file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
	\| exe "normal! g'\"" | endif
endif

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" remap ff as escape key for easier mode switching
inoremap ff <ESC>

" compile LaTeX quick
command Pdf !pdflatex %
command PdfBib !pdflatex % && bibtex %:r && pdflatex % && pdflatex %

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


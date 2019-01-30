" .vimrc - Yochem van Rosmalen
" 1. Plugins
" 2. Colorscheme
" 3. Looks
" 4. Indention
" 5. Lines
" 6. Searching
" 7. Typing
" 8. Modernize
" 9. Random Stuff
" 10. Opening files
" 11. Shell/running
" 12. Statusline


"""""""""""""""""""""""
"      PLUGINS        "
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
Plug 'nvie/vim-flake8'
Plug 'valloric/MatchTagAlways'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/MailApp'
call plug#end()


"""""""""""""""""""""""
"     COLORSCHEME     "
"""""""""""""""""""""""
" make background the same as iterm2 background
set termguicolors

" use syntax highlighting
syntax enable

" use atom's one-dark theme
set background=dark
colorscheme one


"""""""""""""""""""""""
"        LOOKS        "
"""""""""""""""""""""""
" dont show intro message
set shortmess=WIF

" don't show 'Thanks for flying Vim'
set notitle

" split normal
set splitright
set splitbelow


"""""""""""""""""""""""
"      INDENTION      "
"""""""""""""""""""""""
" auto indent
set autoindent

" tab should have the length of four spaces
set tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" don't reset cursor to start of line
set nostartofline

" i really hate folding
set nofoldenable

" atom-like line to show where the 80 char bound is
set colorcolumn=80


"""""""""""""""""""""""
"        LINES        "
"""""""""""""""""""""""
" enable line numbers
set number

" Start scrolling five lines before the horizontal window border
set scrolloff=5

" add empty line without leaving normal mode
set timeoutlen=250
nmap oo m`o<Esc>``
nmap OO m`O<Esc>``


"""""""""""""""""""""""
"      SEARCHING      "
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
"       TYPING        "
"""""""""""""""""""""""
" remap ff as escape key for easier mode switching
inoremap ff <ESC>
inoremap FF <ESC>

" set leader key
let mapleader = ','

" use OS clipboard
set clipboard=unnamed

" replace more characters at once in visual mode
vmap r "_dP

" backspace in insert mode
set backspace=indent,eol,start

" remove trailing whitespaces
nnoremap W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


"""""""""""""""""""""""
"      MODERNIZE      "
"""""""""""""""""""""""
" cursor in insert mode
if !has('nvim')
    set esckeys
endif

" enable mouse in all modes
set mouse=a

" no error bells
set noerrorbells

" make vim more useful
set nocompatible

" fast terminal connections
set ttyfast

" font encoding
set encoding=utf-8

" makes starting up faster
let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'


"""""""""""""""""""""""
"    RANDOM STUFF     "
"""""""""""""""""""""""
" enable filetype for plugins
filetype plugin on
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'

" dont care about spelling
set nospell
let g:markdown_enable_spell_checking = 0

" centralize backups and swaps
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif


"""""""""""""""""""""""
"    OPENING FILES    "
"""""""""""""""""""""""
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

    " stop auto commenting newline
    autocmd FileType * setlocal formatoptions-=cro
endif


"""""""""""""""""""""""
"    SHELL/RUNNING    "
"""""""""""""""""""""""
" autosave when 'running' the file
set autowrite

" clear command output everytime when running
set shell=~/.vim/clear_shell.sh

" compile / run current file
nmap Â :!compile %<CR>

let MailApp_from='Yochem van Rosmalen <yochem@icloud.com>'
"""""""""""""""""""""""
"      STATUSLINE     "
"""""""""""""""""""""""
" always show statusline
set laststatus=2

" don't show mode
set noshowmode

" tbh I copied this so idk what's going on
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ N\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ I\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ R\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ V\ ':''}
set statusline+=%#CursorIM#                                 " colour
set statusline+=\ %f\                                       " relative file name
set statusline+=%#Cursor#                                   " colour
set statusline+=%m                                          " modified [+] flag
set statusline+=%#CursorIM#                                 " colour
set statusline+=\ %{fugitive#statusline()[4:-2]}            " branch name
set statusline+=%#Visual#                                   " colour
set statusline+=%#CursorIM#                                 " colour
set statusline+=%#Cursor#                                   " colour
set statusline+=%#CursorLine#                               " colour
set statusline+=%=                                          " right align
set statusline+=%#Visual#                                   " colour
set statusline+=\ %Y\                                       " file type
set statusline+=%#Cursor#                                   " colour
set statusline+=\ %3l:%-2c\                                 " line + column

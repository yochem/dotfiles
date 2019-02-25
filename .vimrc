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
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'nvie/vim-flake8'
Plug 'valloric/MatchTagAlways'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/MailApp'
Plug 'airblade/vim-gitgutter'
call plug#end()


"""""""""""""""""""""""
"     COLORSCHEME     "
"""""""""""""""""""""""
" use syntax highlighting
syntax enable

" always dark
set background=dark
if $TERM_PROGRAM == 'iTerm.app' && $ITERM_PROFILE == 'One-Dark'
    " make background the same as iterm2 background
    set termguicolors

    " use atom's one-dark theme
    colorscheme onedark
else
    highlight Comment ctermfg=grey
    highlight ColorColumn ctermbg=grey
    highlight ColorColumn ctermfg=black
endif


"""""""""""""""""""""""
"        LOOKS        "
"""""""""""""""""""""""
" dont show intro message
set shortmess=WIFs

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
set smartindent
set smarttab

" tab should have the length of four spaces
set tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" don't reset cursor to start of line
set nostartofline

" i really hate folding
set nofoldenable

" atom-like line to show where the 79 char bound is
set colorcolumn=79


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

" use tab for indention
nnoremap <tab> V>>


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

" toggle NerdTree
map <C-f> :NERDTreeToggle<CR>

" update faster
set updatetime=100


"""""""""""""""""""""""
"    RANDOM STUFF     "
"""""""""""""""""""""""
" enable filetype for plugins
filetype plugin on

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
    autocmd BufRead,BufNewFile *.tex setlocal textwidth=78

    " and .tex files as LaTeX
    autocmd BufRead,BufNewFile *.tex setlocal filetype=tex
    autocmd BufRead,BufNewFile *.tex setlocal textwidth=78

    " set textwidth of .txt files to 78
    autocmd BufRead,BufNewFile *.txt setlocal textwidth=78

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
set shellcmdflag=-lc
set shell=~/.vim/clear_shell.sh

" compile / run current file
nnoremap ® :!compile %<CR>

" set my main mail
let MailApp_from='Yochem van Rosmalen <yochem@icloud.com>'


"""""""""""""""""""""""
"      STATUSLINE     "
"""""""""""""""""""""""
" always show statusline
set laststatus=2

" don't show mode
set noshowmode

set stl=
" show current mode
set stl+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set stl+=%#Cursor#%{(mode()=='i')?'\ \ INSERT\ ':''}
set stl+=%#DiffDelete#%{(mode()==?'r')?'\ \ REPLACE\ ':''}
set stl+=%#DiffChange#%{(mode()==?'v')?'\ \ VISUAL\ ':''}
set stl+=%#DiffChange#%{(mode()=='')?'\ \ VISUAL\ ':''}
set stl+=%#DiffChange#%{(mode()==?'s')?'\ \ SELECT\ ':''}
set stl+=%#DiffChange#%{(mode()=='t')?'\ \ TERM\ ':''}

" get current working directory -> /Users/Yochem/project/
set stl+=%#CursorIM#\ %{getcwd()}/

" relative fail name -> js/main.js
set stl+=%#DiffChange#%f

" show branch name -> (master)
set stl+=%#CursorIM#\ %{fugitive#statusline()[4:-2]} " branch name

" show modified flag, else nothing -> [+]
set stl+=%#Cursor#%{(&mod)?'[+]':''}

" no colour at end
set stl+=%#CursorIM#

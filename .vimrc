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
" nice colorscheme
Plug 'joshdick/onedark.vim'
" better language syntax support
Plug 'sheerun/vim-polyglot'
" always highlight html tags you're currently in
Plug 'valloric/MatchTagAlways', { 'for': 'html' }
" show filetree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" conform vim to editorconfig
Plug 'editorconfig/editorconfig-vim'
" handy git things inside of vim (branch in statusline)
Plug 'tpope/vim-fugitive'
" comment blocks of code
Plug 'tpope/vim-commentary'
" send mails from vim
Plug 'vim-scripts/MailApp'
" show git diff next to linenumbers
"Plug 'mhinz/vim-signify'
call plug#end()


"""""""""""""""""""""""
"     COLORSCHEME     "
"""""""""""""""""""""""
" use syntax highlighting
syntax enable

" always dark
set background=dark

" make background the same as iterm2 background
if $TERM_PROGRAM == 'iTerm.app'
    set termguicolors
endif

" use atom's one-dark theme
colorscheme onedark


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

" replace more characters at once in visual mode
vmap r "_dP

" backspace in insert mode
set backspace=indent,eol,start

" remove trailing whitespaces
nnoremap W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" use tab for indention
nnoremap <tab> V>>

" saving one key with navigating through splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


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
    au BufNewFile,BufRead *.md setlocal filetype=markdown

    " some LaTeX settings
    au BufRead,BufNewFile *.tex setlocal filetype=tex
    au BufRead,BufNewFile *.{tex,txt,md} setlocal textwidth=78

    " start on top and in insertmode with commits
    au FileType gitcommit call setpos('.', [0, 1, 1, 0])
    au FileType gitcommit startinsert

    " stop auto commenting newline
    au FileType * setlocal formatoptions-=cro

    " set scripts to be executable
    au BufWritePost * if getline(1) =~ "^#!" | call setfperm(expand('%'), 'rwxr-xr-x') | endif
    au BufWritePost *.sh silent !chmod +x <afile>

    " highlight non-ascii chars
    highlight nonascii guibg=Blue ctermbg=9
    au BufReadPost * syntax match nonascii "[^\x00-\x7F]"

    " highlight trailing whitespaces except the current line in insertmode
    highlight trailingwhitespace guibg=Red ctermbg=1
    au BufWinEnter * match trailingwhitespace /\s\+$/
    au InsertEnter * match trailingwhitespace /\s\+\%#\@<!$/
    au InsertLeave * match trailingwhitespace /\s\+$/
    au BufWinLeave * call clearmatches()
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
set stl+=%#CursorIM#\ %{(expand('%')=~'^\/.*')?'':getcwd().'/'}
" relative fail name -> js/main.js
set stl+=%#DiffChange#%f

" show branch name -> (master)
set stl+=%#CursorIM#\ %{fugitive#statusline()[4:-2]}\ 

" show modified flag, else nothing -> [+]
set stl+=%#Cursor#%{(&mod)?'[+]':''}

" no colour at end
set stl+=%#CursorIM#

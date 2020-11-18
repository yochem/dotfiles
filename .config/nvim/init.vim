" download vim-plug for the right vim
if has('nvim')
    let plugged_dir = stdpath('data') . '/plugged'
    if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    let plugged_dir = '~/.vim/plugged'
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" all vim-plug plugins
call plug#begin(plugged_dir)
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'yochem/prolog.vim'
Plug 'yochem/vim-mail'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'bitc/vim-bad-whitespace'
Plug 'FooSoft/vim-argwrap'
Plug 'wellle/targets.vim'
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings: set ..., let ...
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

if has("termguicolors")
    set termguicolors
endif

" change the background color of the onedark theme
let s:background = {"gui": "1b1b1b",
    \ "cterm": "235",
    \ "cterm16": "0"
    \ }
autocmd ColorScheme * call onedark#set_highlight("Normal", {"bg":
    \ {"gui": "1b1b1b",
        \ "cterm": "235",
        \ "cterm16": "0"
        \ }})

colorscheme onedark

let mapleader = ','

" dont show unnecessary stuff
set shortmess=WIFs
set notitle
set encoding=utf-8
set nospell
set noerrorbells
set nowrap

" split normal
set splitright
set splitbelow

" make netrw better looking
let g:netrw_banner = 0
let g:netrw_liststyle = 3

set autoindent
set smartindent
set smarttab

" 4 spaces when tab pressed
set tabstop=8
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround

" don't reset cursor to start of line while scrolling
set nostartofline

" i really hate folding
set nofoldenable

" atom-like line to show where the 79 char bound is
set colorcolumn=79

" (relative) line numbers
set number
set relativenumber

" Start scrolling five lines before the vertical window border
set scrolloff=3
set sidescrolloff=3

" add empty line below or above in normal mode
set timeoutlen=250
nmap oo m`o<Esc>``
nmap OO m`O<Esc>``


" search global, highlight, ignore case and go to top when bottom
set gdefault
set hlsearch
set ignorecase
set incsearch
set wrapscan
set wildignore=*.swp,*.bak,*.pyc,*.pdf,*.out,*.aux,*.bbl,*.blg

" use backspace
set backspace=indent,eol,start

" cursor in insert mode
if !has('nvim')
    set esckeys
endif

set mouse=a
set nocompatible
set ttyfast

" makes starting up faster on mac
if has('mac')
    let g:python_host_prog = '/usr/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:clipboard = {
    \ 'name': 'pbcopy',
    \ 'copy': {
    \    '+': 'pbcopy',
    \    '*': 'pbcopy',
    \  },
    \ 'paste': {
    \    '+': 'pbpaste',
    \    '*': 'pbpaste',
    \ },
    \ 'cache_enabled': 0,
    \ }
endif

" update faster
set updatetime=100

" use the systems clipboard
set clipboard=unnamed

" fuzzy find when opening file
set path+=**

filetype plugin on

" improve file-run experience
set autowrite
set shellcmdflag=-lc


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle list wrapping
nmap <leader>a :ArgWrap<CR>

" replace more characters at once in visual mode
vmap r "_dP

" turn off search highlight
nnoremap <silent> <ESC><ESC> :noh<CR>

" when jumping to definition place it in the middle of the screen
nnoremap n nzz

" delete trailing whitespace
nnoremap <silent> W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:noh<CR>

" use arows to quickly scroll
nnoremap <UP> <C-u>
nnoremap <DOWN> <C-d>

" go through visual lines with j and k but don't mess with 10k etc.
" source: http://stackoverflow.com/a/21000307/2580955
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" hate using ctrl and using ctrl-w a lot
nnoremap <space> <C-w>

" Open new file in split
nnoremap <silent> <leader>t :Vexplore<CR>
nnoremap <silent> ZZ :qall<CR>
nmap <leader>c gcc
nnoremap S <nop>
nnoremap Y y$

" don't accidently create macros'
nnoremap Q q
nnoremap q <nop>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kite nicer complete menu and support for go
set completeopt+=menuone,menu,noinsert
let g:kite_tab_complete=1
nnoremap <silent> <leader>gd :KiteGotoDefinition<CR>

let g:ale_sign_error = '!'
let g:ale_sign_warning = '~'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" go to last position when opening file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

filetype on
au BufNewFile,BufRead *.md setlocal filetype=markdown
au BufRead,BufNewFile *.tex setlocal filetype=tex
au BufRead,BufNewFile *.{txt,md} setlocal textwidth=78
au FileType * setlocal formatoptions-=ro

" set scripts to be executable
au BufWritePost * if getline(1) =~ "^#!" | call setfperm(expand('%'), 'rwxr-xr-x') | endif
au BufWritePost *.sh silent !chmod +x <afile>

highlight nonascii guibg=Blue ctermbg=9
au BufReadPost * syntax match nonascii "[^\x00-\x7F]"

au TermOpen * setlocal nonumber norelativenumber

au BufRead,BufNewFile COMMIT_EDITMSG Gdiff

au SwapExists * let v:swapchoice = 'o'
au SwapExists * echoerr 'Found a swapfile, opening read-only'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set noshowmode

let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \ 'left': [['mode', 'paste'],
    \ ['readonly', 'filename', 'gitbranch', 'modified']],
    \ 'right': [['lineinfo'], ['percent'], ['filetype']]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ }
    \ }

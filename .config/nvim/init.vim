" .vimrc - Yochem van Rosmalen

"""""""""""""""""""""""
"      PLUGINS        "
"""""""""""""""""""""""
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
Plug 'vimlab/split-term.vim'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'bitc/vim-bad-whitespace'
Plug 'ycm-core/YouCompleteMe'
Plug 'FooSoft/vim-argwrap'
Plug 'wellle/targets.vim'
call plug#end()


"""""""""""""""""""""""
"     COLORSCHEME     "
"""""""""""""""""""""""
" use syntax highlighting
syntax enable

" use atom's one-dark theme
" better colors in iTerm2
if has("termguicolors")
    set termguicolors
endif

" change the background color of the onedark theme
if has("autocmd")
    if $ITERM_PROFILE == 'One-Light'
        let s:background = {"gui": "000000",
            \ "cterm": "0",
            \ "cterm16": "0"
            \ }
        set background=light
    else
        let s:background = {"gui": "1c1c1c",
            \ "cterm": "235",
            \ "cterm16": "0"
            \ }
    endif
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background })
endif

colorscheme onedark

" set leader key
let mapleader = ','

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

" always show unicode
set encoding=utf-8

" make netrw better looking
let g:netrw_banner = 0
let g:netrw_liststyle = 3

set nowrap

"""""""""""""""""""""""
"      INDENTION      "
"""""""""""""""""""""""
" auto indent
set autoindent
set smartindent
set smarttab

" leave tabs normal
set tabstop=8
" tab should look like 4 spaces
set softtabstop=4
" tab should actually insert spaces
set expandtab
" shift should move 4 spaces
set shiftwidth=4
" https://vi.stackexchange.com/a/9883
set shiftround

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

" easy jumping between lines
set relativenumber

" Start scrolling five lines before the vertical window border
set scrolloff=3
set sidescrolloff=3

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

" go to top when end of file is reached
set wrapscan

set wildignore=*.swp,*.bak,*.pyc,*.pdf,*.out,*.aux,*.bbl,*.blg


"""""""""""""""""""""""
"       TYPING        "
"""""""""""""""""""""""
" toggle list wrapping
nmap <leader>a :ArgWrap<CR>
let g:argwrap_wrap_closing_brace = 0

" replace more characters at once in visual mode
vmap r "_dP

" backspace in insert mode
set backspace=indent,eol,start

" turn off search highlight
nnoremap <silent> <ESC><ESC> :noh<CR>

" when jumping to definition place it in the middle of the screen
nnoremap n nzz

" delete trailing whitespace
nnoremap W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" use arows to quickly scroll
nnoremap <UP> <C-u>
nnoremap <DOWN> <C-d>

" go through visual lines with j and k but don't mess with 10k etc.
" source: http://stackoverflow.com/a/21000307/2580955
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" hate using ctrl and using ctrl-w a lot
nnoremap <space> <C-w>

" Completer (YCM and Kite) settings
nnoremap <silent> gd :YcmCompleter GoToDefinition<CR>
nnoremap <silent> gr :YcmCompleter GoToReferences<CR>
nnoremap <silent> ? :YcmCompleter GetDoc<CR>

let g:ycm_max_num_candidates = 5
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_specific_completion_to_disable = { 'python': 1 }
let g:ycm_filetype_blacklist = { 'python': 1, 'text': 1 }

" Kite nicer complete menu and support for go
set completeopt-=preview
set completeopt+=noinsert
let g:kite_tab_complete=1
let g:kite_supported_languages = ['python', 'go', 'javascript']

" Go to next or previous error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Open new file in split
nnoremap <silent> <leader>t :Vexplore<CR>

let g:ale_sign_error = '!'
let g:ale_sign_warning = '~'

" ZZ is the same as :q, make it act different
nnoremap <silent> ZZ :qall<CR>

" fast comment a line
nmap <leader>c gcc

" don't use visual lines!
nnoremap V <nop>
nnoremap S <nop>
nnoremap Y y$


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

" makes starting up faster
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" update faster
set updatetime=100

" this makes startuptime with neovim much faster
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

" use the systems clipboard
set clipboard=unnamed

" fuzzy find when opening file
set path+=**

"""""""""""""""""""""""
"    RANDOM STUFF     "
"""""""""""""""""""""""
" enable filetype for plugins
filetype plugin on

" dont care about spelling
set nospell

" don't accidently create macros'
nnoremap Q q
nnoremap q <nop>

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

    au BufRead,BufNewFile *.tex setlocal filetype=tex
    au BufRead,BufNewFile *.{txt,md} setlocal textwidth=78

    " " stop auto commenting newline
    au FileType * setlocal formatoptions-=ro

    " set scripts to be executable
    au BufWritePost * if getline(1) =~ "^#!" | call setfperm(expand('%'), 'rwxr-xr-x') | endif
    au BufWritePost *.sh silent !chmod +x <afile>

    " highlight non-ascii chars
    highlight nonascii guibg=Blue ctermbg=9
    au BufReadPost * syntax match nonascii "[^\x00-\x7F]"

    " no linenumbers in terminal mode
    au TermOpen * setlocal nonumber norelativenumber

    au BufRead,BufNewFile COMMIT_EDITMSG Gdiff

    " show me that the file is already open somewhere
    au SwapExists * let v:swapchoice = 'o'
    au SwapExists * echoerr 'Found a swapfile, opening read-only'
endif

"""""""""""""""""""""""
"    SHELL/RUNNING    "
"""""""""""""""""""""""
" autosave when 'running' the file
set autowrite

" clear command output everytime when running
set shellcmdflag=-lc


"""""""""""""""""""""""
"      STATUSLINE     "
"""""""""""""""""""""""
" always show statusline
set laststatus=2

" don't show mode
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

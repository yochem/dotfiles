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
" download vim-plug for the right vim
if has('nvim')
    let plugged_dir = '$XDG_DATA_HOME/nvim/plugged'
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
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
Plug '~/dev/vim-mail'
" show git diff next to linenumbers
Plug 'mhinz/vim-signify'
" Nice prolog syntax highlighting
Plug 'adimit/prolog.vim'
" better implementation for nvim terminal
Plug 'vimlab/split-term.vim'
" just use airline
Plug 'vim-airline/vim-airline'
call plug#end()
let cmdline_map_start = '<leader>s'

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
    let s:background = {"gui": "#1c1c1c",
        \ "cterm": "235",
        \ "cterm16": "0"
        \ }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background })
endif

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

" always show unicode
set encoding=utf-8

" make netrw better looking
let g:netrw_banner = 0
let g:netrw_liststyle = 3


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

" easy jumping between lines
set relativenumber

" Start scrolling five lines before the vertical window border
set scrolloff=3

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
set smartcase

" highlight dynamically
set incsearch

" go to top when end of file is reached
set wrapscan

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
command W let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>

" don't higlight after jumping to definition
nnoremap gd gd:noh<CR>

" when jumping to definition place it in the middle of the screen
nnoremap n nzz

" go through visual lines with j and k but don't mess with 10k etc.
" source: http://stackoverflow.com/a/21000307/2580955
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'


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

" toggle NerdTree
map <leader>f :NERDTreeToggle<CR>

" use <Tab> to complete code
let g:kite_tab_complete=1

" don't show kite's invasive preview
set completeopt-=preview

" update faster
set updatetime=100

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
let g:markdown_enable_spell_checking = 0

" compile / run current file
nmap <leader>r :!%:p<CR>

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
    function CreateBib()
        let _fn=expand('%:r')
        execute '!pdflatex %; bibtex ' . _fn . '; pdflatex %; pdflatex %'
    endfunction

    au BufRead,BufNewFile *.tex setlocal filetype=tex
    au BufRead,BufNewFile *.{tex,txt,md} setlocal textwidth=78
    au Filetype tex nnoremap <leader>r :!pdflatex %<CR>
    au Filetype tex nnoremap <leader>w :silent !pdflatex %<CR>
    au Filetype tex nnoremap <leader>W :call CreateBib()<CR>
    au VimLeave *.tex silent !rm *.aux *.log *.out *.bbl *.blg

    " start on top and in insertmode with commits
    au FileType gitcommit call setpos('.', [0, 1, 1, 0])
    au FileType gitcommit startinsert

    " " stop auto commenting newline
    au FileType * setlocal formatoptions-=ro

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

    " no linenumbers in terminal mode
    au TermOpen * setlocal nonumber norelativenumber
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

let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'
let g:airline_section_x = []
let g:airline_section_y = []
let g:airline_section_warning = []

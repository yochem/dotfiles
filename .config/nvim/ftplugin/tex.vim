" don't two-space after a period when joining lines
set nojoinspaces

setlocal textwidth=78
setlocal formatoptions+=t

" Let user specify latex engine by '% engine' on first line
function LatexRenderer()
    " default
    let render = 'pdflatex'

    let first_line = getline(1)
    if first_line =~ "% .*tex"
        let render = split(first_line)[1]
    endif

    execute '!' . render . ' %'
endfunction

nnoremap <silent> <leader>r :call LatexRenderer()<CR>

" remove all latex help files when closing vim
au VimLeave *.tex silent !rm <afile>:r.{aux,log,out,bbl,blg,toc,bcf,run.xml,fls,fdb_latexmk,synctex.gz}

" open pdf and focus back to vim
nnoremap <silent> <leader>p :silent !open %:r.pdf; open -a iterm<CR><CR>

" stop all that folding
let g:Tex_FoldedSections = ''
let g:Tex_FoldedEnvironments = 'figure,titlepage'
let g:Tex_FoldedMisc = ''

set path+=/usr/local/texlive/2019/texmf-dist/tex/latex

" for thesis
inoremap sota state-of-the-art

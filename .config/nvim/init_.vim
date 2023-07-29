"   _                              _      __      ___           
"  | |                            ( )     \ \    / (_)          
"  | |     __ ___  _____ _ __ ___ |/ ___   \ \  / / _ _ __ ___  
"  | |    / _` \ \/ / _ \ '_ ` _ \  / __|   \ \/ / | | '_ ` _ \ 
"  | |___| (_| |>  <  __/ | | | | | \__ \    \  /  | | | | | | | 
"  |______\__,_/_/\_\___|_| |_| |_| |___/     \/   |_|_| |_| |_|
"
"  :D 


" polyglot highlighting disabled
let g:polyglot_disabled = ['tex']


"###########################################"
"## Key-binds                             ##"
"###########################################"

" spell check in insert
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Ranger setting
let g:ranger_map_keys = 0


"###########################################"
"## Python                                ##"
"###########################################"

au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


"###########################################"
"## latex                                 ##"
"###########################################"

let s:verbatim_envs = ['lstlisting', 'verbatim', 'minted', 'markdown', 'algorithm']


"###########################################"
"## Java                                  ##"
"###########################################"

" autocmd BufNewFile,BufRead *.java call deoplete#enable()
let g:ale_java_javalsp_config = {'java': {'classPath': ['/home/ahsan/git/oxford/misc/algs4.jar']}}




"###########################################"
"## Linter                                ##"
"###########################################"
"
autocmd FileType mkdhaskell setlocal commentstring=--\ %s


"###########################################"
"## Moving between indentation levels     ##"
"###########################################"

function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line      = line('.')
  let column    = col('.')
  let lastline  = line('$')
  let indent    = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [u :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]u :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [U :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]U :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [u <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]u <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [U <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]U <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [u :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]u :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [U :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]U :call NextIndent(1, 1, 1, 1)<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

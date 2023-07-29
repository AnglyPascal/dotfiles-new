"   _                              _      __      ___           
"  | |                            ( )     \ \    / (_)          
"  | |     __ ___  _____ _ __ ___ |/ ___   \ \  / / _ _ __ ___  
"  | |    / _` \ \/ / _ \ '_ ` _ \  / __|   \ \/ / | | '_ ` _ \ 
"  | |___| (_| |>  <  __/ | | | | | \__ \    \  /  | | | | | | |
"  |______\__,_/_/\_\___|_| |_| |_| |___/     \/   |_|_| |_| |_|
"  
"
"  :D 


set nocompatible 
set clipboard=unnamedplus 
source $VIMRUNTIME/mswin.vim 
behave mswin

" polyglot highlighting disabled
let g:polyglot_disabled = ['tex']


"###########################################"
"## Vundle                                ##"
"###########################################"

call plug#begin('~/.vim/plugged')

" Accessories
Plug 'sirver/ultisnips'
Plug '907th/vim-auto-save' 
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs', { 'for': ['python', 'java', 'javascript', 'haskell', 'scala', 'html'] }
Plug 'dense-analysis/ale', { 'for': ['python', 'java', 'javascript'] }
" Plug 'neoclide/coc.nvim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'tpope/vim-surround'
Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-grammarous', { 'for': ['tex', 'text'] }

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'francoiscabrol/ranger.vim', { 'on':  'Ranger' }


" Vim latex
Plug 'lervag/vimtex'

" Color schemes
Plug 'ap/vim-css-color'

" Vim Python
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
" Plug 'davidhalter/jedi-vim'
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }

" Vim Git
Plug 'tpope/vim-fugitive'

" Vim Alignment
Plug 'godlygeek/tabular'

" Vim Java
" Plug 'Shougo/deoplete.nvim'
Plug 'uiiaoo/java-syntax.vim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
Plug 'artur-shaik/vim-javacomplete2'

" Vim Scala
Plug 'derekwyatt/vim-scala'

" Vim Javascript
Plug 'posva/vim-vue'

" Vim Haskell
" Plug 'neovimhaskell/haskell-vim'
Plug 'khardix/vim-literate'


call plug#end()


"###########################################"
"## Global Settings                       ##"
"###########################################"

filetype plugin indent on
syntax on

set textwidth=87
let g:auto_save = 1
set splitright
" set formatoptions-=t

set cin nu rnu ai noswapfile 
set so=10 ts=2 sw=2 sts=2 et 

set bs=indent,eol,start 
set wrap linebreak nolist

set belloff=all
set tags=./.tags,.tags,./tags,tags
map <C-F12> :!ctags -R -f ./.git/tags .<CR>

let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(pdf|xopp)$',
  \ }
let g:ctrlp_working_path_mode = ''

"###########################################"
"## Spelling                              ##"
"###########################################"

setlocal spell
set spellfile=~/.vim/spell/en.utf-8.add
set encoding=utf-8
set spelllang=en_us
set spellcapcheck=


"###########################################"
"## Themes and Colors                     ##"
"###########################################"

set termguicolors
" set background=light
color bestblack
highlight link JavaIdentifier NONE
hi clear SpellBad GrammarBad
au BufEnter,BufRead *.conf setf dosini
au BufNewFile,BufRead * if &syntax == '' | hi SpellBad cterm=underline | endif
let g:ale_java_javalsp_config = {'java': {'classPath': ['/home/ahsan/git/oxford/misc/algs4.jar']}}



"###########################################"
"## UltiSnips                             ##"
"###########################################"

let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["/home/ahsan/.vim/UltiSnips", "UltiSnips"]


"###########################################"
"## CtrlP & NerdTree Blacklist            ##"
"###########################################"

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.aux,*.log,*.pdf,*.pyc
set wildignore+=*.ggb,*.ilg,*.ind,*.fls,*.out,*.svg,*.synctex.gz
set wildignore+=*.idx,*.ggt,*.pdf_tex,*.fdb_latexmk
set wildignore+=*.blg,*.class,*.bbl,*.toc,*.xdv
let NERDTreeIgnore=['\.pyc$', '\~$', '\.class'] 
map <C-n> :NERDTreeToggle<CR>


"###########################################"
"## Key-binds                             ##"
"###########################################"


let mapleader=";"
let maplocalleader=";"

nmap      <C-s>   :up<CR>
imap      <C-s>   <esc><C-s>a
nmap      <s-h>   <c-wl>
nmap      <s-l>   <c-wh>
imap      jk      <esc>
imap      kj      <esc>
" copy twerks
nnoremap  d       "_d
" break or join paras
nmap      gj      vipgq
nmap      fj      vipJ
" move between splits
nnoremap H gT
nnoremap L gt
nnoremap  <S-J>   <C-W><C-J>
nnoremap  <S-K>   <C-W><C-K>
nnoremap  <C-S-L>   <C-W><C-L>
nnoremap  <C-S-H>   <C-W><C-H>
" movement in wraps 
noremap   <silent> k gk
noremap   <silent> j gj
noremap   <silent> 0 g0
noremap   <silent> $ g$
noremap   <silent> ^ g^
noremap   <silent> gk ==gqq
noremap   <silent> gK =%
onoremap  <silent> j gj
onoremap  <silent> k gk
" spell check in insert
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

nmap  <C-k> [[
nmap  <C-j> ]]

autocmd FileType java imap ;ll :!javac<space>%;f=%;<space>java<space>${f\%.*}<CR>
autocmd FileType java nmap ;ll :!javac<space>%;f=%;<space>java<space>${f\%.*}<CR>
autocmd FileType python imap ;ll :!python<space>%<CR>
autocmd FileType python nmap ;ll :!python<space>%<CR>
autocmd FileType python nmap ;lv :!python<space>%
autocmd FileType javascript imap ;ll :!node<space>%<CR>
autocmd FileType javascript nmap ;ll :!node<space>%<CR>
autocmd FileType javascript nmap ;lv :!node<space>%
autocmd FileType bash imap ;ll :!bash<space>%<CR>
autocmd FileType bash nmap ;ll :!bash<space>%<CR>
autocmd FileType bash nmap ;lv :!bash<space>%
autocmd FileType cpp imap ;ll :!gcc<space>%<CR>
autocmd FileType cpp nmap ;ll :!gcc<space>%<CR>


inoremap <Up> <Nop>
inoremap <Right> <Nop>
inoremap <Left> <Nop>
inoremap <Down> <Nop>

" Ranger setting
let g:ranger_map_keys = 0
map <leader>f :Ranger<CR>


"###########################################"
"## Python                                ##"
"###########################################"

set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1

au BufNewFile, BufRead *.py
    \ set tabstop     = 4
    \ set softtabstop = 4
    \ set shiftwidth  = 4
    \ set textwidth   = 90
    \ set expandtab
    \ set autoindent
    \ set fileformat  = unix

au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufRead, BufNewFile *config.py set filetype=python


"###########################################"
"## C++                                   ##"
"###########################################"

set hls is    " highlight search 
autocmd FileType c,cpp,java nnoremap <silent> <C-l> :nohl<CR>:ClangFormat<CR><C-l>
autocmd FileType c,cpp,java imap <C-l> <esc><C-l>a

" compilation 
let $CXX='g++' 
let $CXXFLAGS='-O2 -DLOCAL'

autocmd filetype c,cpp nmap <C-b> <C-s>:silent make %<\|redraw!\|cw<CR> 
autocmd filetype c,cpp imap <C-b> <esc><C-b>

autocmd filetype c,cpp nmap <C-x> <C-b>:!./%:r<CR>
autocmd filetype c,cpp imap <C-x> <esc><C-x>


"###########################################"
"## latex                                 ##"
"###########################################"

let g:tex_flavor='lualatex'
let g:vimtex_quickfix_mode=0
let g:Tex_FormatDependency_dvi='dvi,ps,pdf'
let g:vimtex_view_method='zathura'
let g:Tex_BibtexFlavor = 'biber'

set conceallevel=2
let g:tex_conceal="abdgm"
let g:tex_conceal_frac=1
let g:vimtex_matchparen_enabled=0
let g:matchup_override_vimtex=1
let g:vimtex_delim_stopline=100
let s:verbatim_envs = ['lstlisting', 'verbatim', 'minted', 'markdown', 'algorithm']
" let g:vimtex_toc_custom_matchers = [
"             \ { 'mysection' : 'My Custom Environment',
"             \   're' : '\v^\s*\\begin\{mycustomenv\}' }
"             \]

autocmd FileType tex,text setlocal spell spelllang=en_us
autocmd FileType tex,text inoremap <buffer> <C-l> <c-g>u<Esc>:nohl<CR>[s1z=`]a<c-g>u
autocmd FileType tex,text nnoremap <buffer> <C-l> 1z=
autocmd FileType tex let b:vimtex_main = "main.tex"
" autocmd FileType tex set so=10 ts=2 sw=2 sts=2 et
autocmd FileType tex setlocal textwidth=87
autocmd FileType tex setlocal foldmethod=marker foldmarker=BEGIN,END
autocmd BufNewFile,BufRead *.cls set filetype=tex syntax=tex

autocmd FileType tex,text vnoremap mj :s/\\(\(.\{-}\)\\)/\\\[\1\\\]/g
autocmd FileType tex,text nnoremap mj v%:s/\%V\\(\(.\{-}\)\\)/\\\[\1\\\]/
autocmd FileType tex,text vnoremap nj :s/\\\[\(.\{-}\)\\\]/\\(\1\\)/g
autocmd FileType tex,text nnoremap nj v%:s/\\\[\(.\{-}\)\\\]/\\(\1\\)/



" let g:vimtex_compiler_latexmk = {'continuous': 0}

" augroup MyVimtex
"   autocmd!
"   autocmd User VimtexEventQuit call vimtex#latexmk#clean(0)
" augroup END

hi clear Conceal


"###########################################"
"## JavaScript                            ##"
"###########################################"



"###########################################"
"## Java                                  ##"
"###########################################"

" autocmd BufNewFile,BufRead *.java call deoplete#enable()
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java JCEnable

" call g:deoplete#custom#option({
"       \ 'enable-smart-case': 1,
"       \ 'sourse': {'java': ['jc', 'javacomplete2', 'file', 'buffer', 'ultisnips']}
"       \ })

imap <C-j> <C-n>



"###########################################"
"## Linter                                ##"
"###########################################"

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'

let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'

let g:ale_open_list = 0
let g:ale_loclist = 0

let g:ale_linters = {
      \  'cs':['syntax', 'semantic', 'issues'],
      \  'java': ['javac'],
      \  'javascript': ['eslint'],
      \  'tex': [],
      \  'python': ['pylint'],
      \ }

let g:ale_haskell_ghc_options = '-fno-code -v0 -dynamic'
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


if &term == "alacritty"        
  let &term = "xterm-256color"
endif

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 5d9b8aeef67545f35038c547c9c70692 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/ahsan/.opam/4.14.0/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line

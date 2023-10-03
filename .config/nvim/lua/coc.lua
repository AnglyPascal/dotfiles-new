local au = require('au')
local api = vim.api
local cmd = vim.cmd
local set = vim.opt
local map = require("keybinds").map

-- CoC extensions ----------------
vim.g.coc_global_extensions = {'coc-tsserver'}

-- CocMapping ------------

map("n", "gK", ":call ShowDocumentation()<CR>", { silent = true })

cmd([[
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('gK', 'in')
    endif
  endfunction

  inoremap <silent><expr> <C-k> coc#refresh().
]])

-- JS TS -----------------------------
--------------------------------------

au.FileType = {
  'javascript,typescript,javascriptreact,typescriptreact,ocaml,c,cpp,rust',
  function()
    cmd([[
      inoremap <expr><Up> coc#pum#visible() ? coc#pum#prev(1) : ""
      inoremap <silent><expr> <Down>
            \ coc#pum#visible() ? coc#pum#next(1): ""
      inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

      " Use `[g` and `]g` to navigate diagnostics
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      " GoTo code navigation.

      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)
    ]])
    map("n", "<leader>f", ":Format<CR>")
    cmd([[
      command! -nargs=0 Format :call CocActionAsync('format')
    ]])
  end
}

-- Overriding cpp formatter
au.FileType = {
  'cpp',
  function()
    map("n", "<leader>f", ":<C-u>ClangFormat<CR>")
  end
}

au({'BufEnter', 'BufRead'}, {
    '*.y,*.l',
    function()
      map("n", "<leader>f", "<nop>")
    end,
  })

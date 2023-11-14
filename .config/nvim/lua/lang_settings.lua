local au = require('au')
local api = vim.api
local cmd = vim.cmd
local set = vim.opt
local map = require("keybinds").map


-- Dosini ----------------------------
--------------------------------------
--
au({'BufEnter', 'BufRead'}, {
    '*.conf',
    function()
      vim.opt.filetype = "dosini"
      vim.cmd([[hi clear SpellBad]])
    end,
  })

-- Assembly --------------------------
--------------------------------------
--
au({'BufEnter', 'BufRead'}, {
    '*.s',
    function()
      vim.opt.filetype = "gas"
      vim.cmd([[hi clear SpellBad]])
    end,
  })

-- p ----------------------------
--------------------------------------
--
au({'BufEnter', 'BufRead'}, {
    '*.p',
    function()
      vim.opt.filetype = "pascal"
      vim.cmd([[hi clear SpellBad]])
    end,
  })


-- Markdown --------------------------
--------------------------------------
--
vim.g.vim_markdown_follow_anchor = 1


-- Auxiliary Filetypes ---------------
--------------------------------------
--
au.BufEnter = {
  '*.txt',
  function()
    if vim.bo.buftype == 'help' then
      cmd([[wincmd J]])
      local nr = api.nvim_get_current_buf()
      local options = { noremap = true, silent = true }
      api.nvim_buf_set_keymap(nr, 'n', 'q', ':q<CR>', options)
    end
  end,
}

au.FileType = {
  'qf',
  function()
    if vim.bo.buftype == 'quickfix' then
      local nr = api.nvim_get_current_buf()
      local options = { noremap = true, silent = true }
      api.nvim_buf_set_keymap(nr, 'n', 'q', ':q<CR>', options)
    end
  end
}

au.FileType = {
  'nerdtree',
  function()
    if vim.bo.buftype == 'nofile' then
      local nr = api.nvim_get_current_buf()
      local options = { noremap = true, silent = true }
      api.nvim_buf_set_keymap(nr, 'n', 'q', ':q<CR>', options)
    end
  end
}

-- Text  -----------------------------
--------------------------------------
--
au.FileType = {
  'markdown,tex,text,md',
  function()
    set.spell = true
    set.spelllang = "en_gb"

    map("i", "<C-l>", "<c-g>u<Esc>:nohl<CR>[s1z=`]a<c-g>u")
    map("n", "<C-l>", "i<c-g>u<Esc>:nohl<CR>[s1z=`]a<c-g>u<Esc>")

    cmd([[ hi SpellBad cterm=underline ]])
  end
}


-- LaTeX -----------------------------
--------------------------------------

-- settings --
au.FileType = {
  'tex',
  function()
    set.spell = true
    set.spelllang = "en_us"

    cmd([[ set ts=4 sw=4 sts=4 et autoindent ]])
    set.foldmethod = 'marker'
    set.foldmarker = 'BEGIN,END'
    
    -- vim.bo.vimtex_main = "main.tex"

    map("v", "<leader>m", ":s/\\\\(\\(.\\{-}\\)\\\\)/\\\\[\\1\\\\]/g<CR>")
    map("v", "<leader>n", ":s/\\\\\\[\\(.\\{-}\\)\\\\\\]/\\\\(\\1\\\\)/g<CR>")
    map("n", "<leader>m", "v:s/\\\\(\\(.\\{-}\\)\\\\)/\\\\[\\1\\\\]/g<CR>")
    map("n", "<leader>n", "v:s/\\\\\\[\\(.\\{-}\\)\\\\\\]/\\\\(\\1\\\\)/<CR>")
    map("n", "<leader>f", "==<Plug>latexfmt_format")
    map("v", "<leader>e", "'<,'>s/\\%V\\_.*\\%V./\\t\\\\begin{enumerate}[label=(\\\\arabic*)]^M&^M\\t\\\\end{enumerate}/g | '<,'>s/(\\d*)/\\\\item/g")
    map("v", "<leader>a", 'c\\ifextraA<CR><c-r><c-o>"\\fi <esc>')
    map("v", "<leader>b", 'c\\ifextraB<CR><c-r><c-o>"\\fi <esc>')
    map("v", "<leader>c", 'c\\ifextraC<CR><c-r><c-o>"\\fi <esc>')

    map("n", "csm", "<Plug>(vimtex-env-change-math)")
    map("n", "dsm", "<Plug>(vimtex-env-delete-math)")
    map("n", "tsm", "<Plug>(vimtex-env-toggle-math)")

    cmd([[ hi clear Conceal ]])

    vim.g.tex_flavor = 'lualatex'
    vim.g.vimtex_quickfix_mode = 0
    vim.g.Tex_FormatDependency_dvi = 'dvi,ps,pdf'
    -- vim.g.vimtex_view_method = 'llpp'
    vim.g.vimtex_view_general_viewer = 'zathura'
    vim.g.Tex_BibtexFlavor  =  'biber'

    vim.g.tex_conceal = "abdgm"
    vim.g.tex_conceal_frac = 1
    vim.g.vimtex_matchparen_enabled = 0
    vim.g.matchup_override_vimtex = 1
    vim.g.vimtex_delim_stopline = 100

  end
}

-- cls files --
au({'BufEnter', 'BufRead'}, {
    '*.cls',
    function()
      set.filetype = "tex"
      set.syntax = "tex"
    end,
  })


-- Scala -----------------------------
--------------------------------------

-- compile --
au.FileType = {
  'scala',
  function()
    map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")
    map("n", "<leader>i", "<cmd>:MetalsOrganizeImports<CR>")

    map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>")
    map("n", "gK", "<cmd>lua vim.lsp.buf.hover()<CR>")
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
    map("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
    map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
    map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

    -- all workspace diagnostics
    map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) 
    -- all workspace errors
    map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) 
    -- all workspace warnings
    map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) 

    map("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>")
    map("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>")
  end
}


-- Java ------------------------------
--------------------------------------

-- compile --
au.FileType = {
  'java',
  function()
    map("i", ";ll", ":!javac<space>%;f=%;<space>java<space>${f%.*}<CR>")
    map("n", ";ll", ":!javac<space>%;f=%;<space>java<space>${f%.*}<CR>")
  end
}

-- settings --
au.FileType = {
  'java',
  function()
    -- cmd([[ setlocal omnifunc=javacomplete#Complete ]])
    -- cmd([[ JCEnable ]])
  end
}


-- Ocaml ----------------------------
--------------------------------------

cmd([[
let s:opam_share_dir = system("opam var share")
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
let s:opam_available_tools = []
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if isdirectory(s:opam_share_dir . "/" . tool)
    call add(s:opam_available_tools, tool)
    call s:opam_configuration[tool]()
  endif
endfor
if count(s:opam_available_tools, "ocp-indent") == 0
  source $HOME/.opam/ocp-indent/vim/indent/ocaml.vim
endif
]])


-- Python ----------------------------
--------------------------------------

-- compile --
au.FileType = {
  'python',
  function()
    map("i", "<leader>ll", ":!python<space>%<CR>")
    map("n", "<leader>ll", ":!python<space>%<CR>")
    map("v", "<leader>ll", ":!python<space>%")
    map("n", "<leader>f", ":%!python -m macchiato<CR>")
  end
}

-- settings --
au.FileType = {
  'python',
  function()
    vim.g.python_highlight_all=1

    set.foldmethod = 'indent'
    set.foldlevel  = 99
    set.tabstop = 4
    set.softtabstop = 4
    set.shiftwidth = 4
    set.textwidth = 79
    -- set.expandtab = true
    set.autoindent = true
    set.fileformat = unix

    vim.g.SimpylFold_docstring_preview = 1

    cmd([[
      "python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
    ]])
  end
}

-- set config.py type to python --
au({'BufNewFile', 'BufRead'}, {
    '*config.py',
    function()
      vim.opt.filetype = "python"
    end,
  })


-- JavaScript ------------------------
--------------------------------------

-- compile --
au.FileType = {
  'javascript',
  function()
    map("i", ";ll", ":!node<space>%<CR>")
    map("n", ";ll", ":!node<space>%<CR>")
    map("v", ";ll", ":!node<space>%")
  end
}

-- Bash ------------------------------
--------------------------------------

-- compile --
au.FileType = {
  'bash',
  function()
    map("i", ";ll", ":!bash<space>%<CR>")
    map("n", ";ll", ":!bash<space>%<CR>")
    map("v", ";ll", ":!bash<space>%")
  end
}



-- Cpp -------------------------------
--------------------------------------

-- compile --
au.FileType = {
  'cpp',
  function()
    map("i", ";ll", ":!gcc<space>%<CR>")
    map("n", ";ll", ":!gcc<space>%<CR>")
    -- map("n", "<leader>f", ":<C-u>ClangFormat<CR>")
  end
}

-- Haskell ---------------------------
--------------------------------------

au.FileType = {
  'haskell',
  function()
    map("n", "<leader>f", ":Hindent<CR>")
  end
}

vim.g.ale_haskell_ghc_options = '-dynamic'
vim.g.hindent_on_save = 0


local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})


-- -- TIP: action can be a ex-cmd or a lua function
-- au.BufRead = function()
--     print(vim.bo.filetype)
-- end

-- au.BufRead = { '*.txt', 'echo &ft' }

-- -- # Autocmd with multiple event: au(events: table, cmd: string | fn | {pattern:
-- string, action: string | fn})

-- -- For this you can just call the required module just like a function au({
-- 'BufNewFile', 'BufRead' }, { '.eslintrc,.prettierrc,*.json*', function()
-- vim.bo.filetype = 'json' end, })

-- -- # Autocmd group: au.group(group: string, cmds: fn(au) | {event: string, pattern:
-- string, action: string | fn})

-- -- 1. Where action is a ex-cmd
-- au.group('PackerGroup', {
--     { 'BufWritePost', 'plugins.lua', 'source <afile> | PackerCompile' },
-- })

-- -- 2. Where action is a function
-- au.group('CocOverrides', {
--     {
--         'FileType',
--         'typescript,json',
--         function()
--             vim.api.nvim_buf_set_option(0, 'formatexpr', "CocAction('formatSelected')")
--         end,
--     },
--     {
--         'User',
--         'CocJumpPlaceholder',
--         function()
--             vim.fn.CocActionAsync('showSignatureHelp')
--         end,
--     },
-- })


-- -- 3. Or behold some meta-magic
-- -- You can give a function as a second arg which receives aucmd-metatable as an argument
-- -- Which you can use to set autocmd individually
-- au.group('CocOverrides', function(grp)
--     grp.FileType = {
--         'typescript,json',
--         function()
--             vim.api.nvim_buf_set_option(0, 'formatexpr', "CocAction('formatSelected')")
--         end,
--     }
--     grp.User = {
--         'CocJumpPlaceholder',
--         function()
--             vim.fn.CocActionAsync('showSignatureHelp')
--         end,
--     }
-- end)

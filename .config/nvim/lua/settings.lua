local api = vim.api
local cmd = vim.cmd
local set = vim.opt
local au = require('au')

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'v', api.node.open.horizontal, opts('vertical split'))
  vim.keymap.set('n', 's', api.node.open.vertical, opts('vertical split'))
  vim.keymap.set('n', 't', api.node.open.tab, opts('vertical split'))
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  on_attach = my_on_attach,
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

set.compatible = false
cmd([[
  filetype plugin indent on

  set cin nu rnu ai noswapfile 
  set so=10 ts=2 sw=2 sts=2 et 

  set bs=indent,eol,start 
  set wrap linebreak nolist

  set belloff=all
  set tags=./.tags,.tags,./tags,tags
]])
set.textwidth = 87
set.mouse = ""
vim.g.auto_save = 1
set.splitright = true
set.signcolumn = "number"
set.conceallevel = 2

-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
vim.g.shortmess = "atToOc"


-- Spelling ----------------------
set.spellfile = "/home/ahsan/.config/nvim/spell/en.utf-8.add"
set.encoding = "utf-8"
cmd([[ 
  setlocal spell 
  hi link JavaIdentifier NONE 
  set spell spelllang=en_gb
]])

-- turn off spelling for any file with syntax on
au.BufEnter = 
  function()
    if vim.o.syntax == '' then
      vim.cmd([[hi SpellBad cterm=underline]])
    else
      vim.cmd([[hi clear SpellBad]])
    end
  end

-- Themes and Colors -------------
set.termguicolors = true

-- Indent guids -----------------
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_color_change_percent = 5

-- CtrlP wildignores ------------
set.wildignore:append("*/tmp/*,*.so,*.swp,*.zip,*.aux,*.log,*.pdf,*.pyc,*.o")
set.wildignore:append("*.ggb,*.ilg,*.ind,*.fls,*.out,*.svg,*.synctex.gz")
set.wildignore:append("*.idx,*.ggt,*.pdf_tex,*.fdb_latexmk")
set.wildignore:append("*.blg,*.class,*.bbl,*.toc,*.xdv,*.ent")

vim.g.ctrlp_working_path_mode = ''
cmd([[
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|dist\|target\|\.bloop\|\.metals',
    \ 'file': '\v\.(pdf|xopp)$',
\ }
]])

-- Highlight yank ----------------
-- https://neovim.io/doc/user/lua.html#lua-highlight
cmd([[ au TextYankPost * silent! lua vim.highlight.on_yank() ]])


-- Git Gutter --------------------
vim.g.gitgutter_highlight_lines = 1

-- Completion --------------------
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- I use tabs... some say you should stick to ins-completion 
    -- but this is just here as an example
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
})

-- UltiSnips ---------------------
vim.g.UltiSnipsExpandTrigger       = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger  = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.UltiSnipsEditSplit           = "vertical"
vim.g.UltiSnipsSnippetDirectories = {"/home/ahsan/.vim/UltiSnips", "UltiSnips"}

-- Linter ------------------------

vim.g.ale_echo_msg_error_str = 'E'
vim.g.ale_echo_msg_warning_str = 'W'

vim.g.ale_sign_error = 'E'
vim.g.ale_sign_warning = 'W'

vim.g.ale_open_list = 0
vim.g.ale_loclist = 0

vim.g.ale_linters = {
  cs = {'syntax', 'semantic', 'issues'},
  java = {'javac'},
  javascript = {'eslint'},
  typescript = {'eslint'},
  typescriptreact = {'eslint'},
  vim = {'vint'},
  tex = {},
  python = {'pylint'},
  ocaml = {'merlin'},
  cpp = {},
  c = {},
}

vim.g.ale_fixers = {
  javascript = {'prettier', 'eslint'},
  typescript = {'prettier', 'eslint'},
  typescriptreact = {'prettier', 'eslint'},
  ocaml = {'ocamlformat'},
  cpp = {}
}

vim.g.ale_haskell_ghc_options = '-fno-code -v0 -dynamic'
vim.g.ale_cpp_clangd_options = '-std=c++17 -Wall'
vim.g.ale_cpp_cc_options = '-std=c++17 -Wall'


-- LuaLine ------------------------
--
require('lualine').setup {
  options = { theme = 'nord', },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}

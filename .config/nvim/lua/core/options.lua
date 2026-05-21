local opt = vim.opt
local g = vim.g

-- General settings
opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.swapfile = false
opt.scrolloff = 10
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.backspace = { "indent", "eol", "start" }
opt.wrap = true
opt.linebreak = true
opt.list = false
opt.belloff = "all"
opt.tags = { "./.tags", ".tags", "./tags", "tags" }
opt.textwidth = 87
opt.mouse = ""
opt.splitright = true
opt.signcolumn = "number"
opt.foldenable = false
opt.conceallevel = 2
opt.termguicolors = true

-- Global completion settings
opt.completeopt = { "menuone", "noinsert", "noselect" }
g.shortmess = "atToOc"

-- Spelling
opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
opt.encoding = "utf-8"
opt.spell = false
opt.spelllang = "en_gb"

-- Wildignore patterns
opt.wildignore:append("*/tmp/*,*.so,*.swp,*.zip,*.aux,*.log,*.pdf,*.pyc,*.o")
opt.wildignore:append("*.ggb,*.ilg,*.ind,*.fls,*.out,*.svg,*.synctex.gz")
opt.wildignore:append("*.idx,*.ggt,*.pdf_tex,*.fdb_latexmk")
opt.wildignore:append("*.blg,*.class,*.bbl,*.toc,*.xdv,*.ent")

-- UltiSnips
g.UltiSnipsExpandTrigger = '<tab>'
g.UltiSnipsJumpForwardTrigger = '<tab>'
g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
g.UltiSnipsEditSplit = "vertical"
g.UltiSnipsSnippetDirectories = { vim.fn.expand("~/.vim/UltiSnips"), "UltiSnips" }

-- Python
g.python_highlight_all = 1

-- LaTeX
g.tex_flavor = 'lualatex'
g.vimtex_quickfix_mode = 0
g.tex_conceal = "abdgm"
g.tex_conceal_frac = 1
g.vimtex_matchparen_enabled = 0
g.matchup_override_vimtex = 1

-- LaTeX format
g.latexfmt_no_join_any = {
  '\\ifextraC', '\\ifextraA', '\\ifextraB', '\\fi', '\\else'
}


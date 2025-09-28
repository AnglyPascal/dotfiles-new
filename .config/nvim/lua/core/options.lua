local opt = vim.opt
local g = vim.g

-- General settings
opt.compatible = false
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
opt.conceallevel = 2
opt.termguicolors = true

-- Global completion settings
opt.completeopt = { "menuone", "noinsert", "noselect" }
g.shortmess = "atToOc"

-- Spelling
opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")
opt.encoding = "utf-8"
opt.spell = true
opt.spelllang = "en_gb"

-- Wildignore patterns
opt.wildignore:append("*/tmp/*,*.so,*.swp,*.zip,*.aux,*.log,*.pdf,*.pyc,*.o")
opt.wildignore:append("*.ggb,*.ilg,*.ind,*.fls,*.out,*.svg,*.synctex.gz")
opt.wildignore:append("*.idx,*.ggt,*.pdf_tex,*.fdb_latexmk")
opt.wildignore:append("*.blg,*.class,*.bbl,*.toc,*.xdv,*.ent")

-- Plugin-specific globals
g.auto_save = 1
g.indent_guides_guide_size = 1
g.indent_guides_color_change_percent = 5
g.ctrlp_working_path_mode = ''

-- -- Git gutter
-- g.gitgutter_highlight_lines = 1
-- g.gitgutter_sign_added = '+'
-- g.gitgutter_sign_modified = '~'
-- g.gitgutter_sign_removed = '-'
-- g.gitgutter_sign_removed_first_line = '-'
-- g.gitgutter_sign_modified_removed = '~'

-- UltiSnips
g.UltiSnipsExpandTrigger = '<tab>'
g.UltiSnipsJumpForwardTrigger = '<tab>'
g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
g.UltiSnipsEditSplit = "vertical"
g.UltiSnipsSnippetDirectories = { vim.fn.expand("~/.vim/UltiSnips"), "UltiSnips" }

-- -- ALE
-- g.ale_echo_msg_error_str = 'E'
-- g.ale_echo_msg_warning_str = 'W'
-- g.ale_sign_error = 'E'
-- g.ale_sign_warning = 'W'
-- g.ale_open_list = 0
-- g.ale_loclist = 0

-- Markdown
g.vim_markdown_follow_anchor = 1

-- Python
g.python_highlight_all = 1

-- LaTeX
g.tex_flavor = 'lualatex'
g.vimtex_quickfix_mode = 0
g.Tex_FormatDependency_dvi = 'dvi,ps,pdf'
g.vimtex_view_general_viewer = 'zathura'
g.vimtex_view_method = 'zathura'
g.vimtex_view_automatic = 0
g.vimtex_quickfix_open_on_warning = 0
g.Tex_BibtexFlavor = 'biber'
g.tex_conceal = "abdgm"
g.tex_conceal_frac = 1
g.vimtex_matchparen_enabled = 0
g.matchup_override_vimtex = 1
g.vimtex_delim_stopline = 100

-- LaTeX format
g.latexfmt_no_join_any = {
  '\\ifextraC', '\\ifextraA', '\\ifextraB', '\\fi', '\\else'
}

-- C++
g.cpp_type_name_highlight = 1

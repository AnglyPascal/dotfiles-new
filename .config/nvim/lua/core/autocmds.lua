local api = vim.api

-- Create augroups
local general_group = api.nvim_create_augroup("General", { clear = true })
local filetype_group = api.nvim_create_augroup("FileTypes", { clear = true })
local text_group = api.nvim_create_augroup("TextFiles", { clear = true })
local spell_group = api.nvim_create_augroup("SpellCheck", { clear = true })

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  group = general_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Turn off spelling for files with syntax highlighting
api.nvim_create_autocmd("BufEnter", {
  group = spell_group,
  callback = function()
    if vim.o.syntax == '' then
      vim.cmd([[hi SpellBad cterm=underline]])
    else
      vim.cmd([[hi clear SpellBad]])
    end
  end,
})

-- Help files
api.nvim_create_autocmd("BufEnter", {
  group = general_group,
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == 'help' then
      vim.cmd([[wincmd J]])
      local bufnr = api.nvim_get_current_buf()
      vim.keymap.set('n', 'q', ':q<CR>', { buffer = bufnr, noremap = true, silent = true })
    end
  end,
})

-- Quickfix
api.nvim_create_autocmd("FileType", {
  group = general_group,
  pattern = "qf",
  callback = function()
    if vim.bo.buftype == 'quickfix' then
      local bufnr = api.nvim_get_current_buf()
      vim.keymap.set('n', 'q', ':q<CR>', { buffer = bufnr, noremap = true, silent = true })
    end
  end,
})

-- Text files (Markdown, TeX, Text)
api.nvim_create_autocmd("FileType", {
  group = text_group,
  pattern = { "markdown", "tex", "text", "md" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
    vim.cmd([[ hi SpellBad cterm=underline ]])
  end,
})

-- LaTeX specific
api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "tex",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.foldmethod = 'marker'
    vim.opt_local.foldmarker = 'BEGIN,END'

    -- LaTeX-specific keymaps
    vim.keymap.set("v", "<leader>m", ":s/\\\\(\\(.\\{-}\\)\\\\)/\\\\[\\1\\\\]/g<CR>", opts)
    vim.keymap.set("v", "<leader>n", ":s/\\\\\\[\\(.\\{-}\\)\\\\\\]/\\\\(\\1\\\\)/g<CR>", opts)
    vim.keymap.set("n", "<leader>m", "v:s/\\\\(\\(.\\{-}\\)\\\\)/\\\\[\\1\\\\]/g<CR>", opts)
    vim.keymap.set("n", "<leader>n", "v:s/\\\\\\[\\(.\\{-}\\)\\\\\\]/\\\\(\\1\\\\)/<CR>", opts)
    vim.keymap.set("n", "<leader>f", "==<Plug>latexfmt_format", opts)
    vim.keymap.set("v", "<leader>e", "'<,'>s/\\%V\\_.*\\%V./\\t\\\\begin{enumerate}[label=(\\\\arabic*)]^M&^M\\t\\\\end{enumerate}/g | '<,'>s/(\\d*)/\\\\item/g", opts)
    vim.keymap.set("v", "<leader>a", 'c\\ifextraA<CR><c-r><c-o>"\\fi <esc>', opts)
    vim.keymap.set("v", "<leader>b", 'c\\ifextraB<CR><c-r><c-o>"\\fi <esc>', opts)
    vim.keymap.set("v", "<leader>c", 'c\\ifextraC<CR><c-r><c-o>"\\fi <esc>', opts)

    vim.keymap.set("n", "csm", "<Plug>(vimtex-env-change-math)", opts)
    vim.keymap.set("n", "dsm", "<Plug>(vimtex-env-delete-math)", opts)
    vim.keymap.set("n", "tsm", "<Plug>(vimtex-env-toggle-math)", opts)

    vim.cmd([[ hi clear Conceal ]])
  end,
})

-- Python
api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "python",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.opt_local.foldmethod = 'indent'
    vim.opt_local.foldlevel = 99
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.textwidth = 79
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = 'unix'

    -- Python keymaps
    vim.keymap.set("i", "<leader>ll", ":!python %<CR>", opts)
    vim.keymap.set("n", "<leader>ll", ":!python %<CR>", opts)
    vim.keymap.set("v", "<leader>ll", ":!python %", opts)
    vim.keymap.set("n", "<leader>f", ":%!python -m macchiato<CR>", opts)
  end,
})

-- JavaScript
api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "javascript",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("i", ";ll", ":!node %<CR>", opts)
    vim.keymap.set("n", ";ll", ":!node %<CR>", opts)
    vim.keymap.set("v", ";ll", ":!node %", opts)
  end,
})

-- Bash
api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "bash",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("i", ";ll", ":!bash %<CR>", opts)
    vim.keymap.set("n", ";ll", ":!bash %<CR>", opts)
    vim.keymap.set("v", ";ll", ":!bash %", opts)
  end,
})

-- C++
api.nvim_create_autocmd("FileType", {
  group = filetype_group,
  pattern = "cpp",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("i", ";ll", ":!gcc %<CR>", opts)
    vim.keymap.set("n", ";ll", ":!gcc %<CR>", opts)
    vim.keymap.set("n", "<leader>f", ":<C-u>ClangFormat<CR>", opts)
  end,
})

-- Custom filetypes
api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  group = filetype_group,
  pattern = "*.conf",
  callback = function()
    vim.opt_local.filetype = "conf"
    vim.cmd([[hi clear SpellBad]])
  end,
})

api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  group = filetype_group,
  pattern = "*.strace",
  callback = function()
    vim.opt_local.filetype = "strace"
  end,
})

api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  group = filetype_group,
  pattern = "*.s",
  callback = function()
    vim.opt_local.filetype = "gas"
    vim.cmd([[hi clear SpellBad]])
  end,
})

api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  group = filetype_group,
  pattern = "*.p",
  callback = function()
    vim.opt_local.filetype = "pascal"
    vim.cmd([[hi clear SpellBad]])
  end,
})

api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
  group = filetype_group,
  pattern = "*.cls",
  callback = function()
    vim.opt_local.filetype = "tex"
    vim.opt_local.syntax = "tex"
  end,
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = filetype_group,
  pattern = "*config.py",
  callback = function()
    vim.opt_local.filetype = "python"
  end,
})

local api = vim.api

-- Create augroups
local general_group = api.nvim_create_augroup("General", { clear = true })
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
api.nvim_create_autocmd("FileType", {
  group = general_group,
  pattern = "help",
  callback = function()
    vim.cmd([[wincmd J]])
    vim.keymap.set('n', 'q', '<cmd>q<CR>', { buffer = true, silent = true })
  end,
})

-- Quickfix
api.nvim_create_autocmd("FileType", {
  group = general_group,
  pattern = "qf",
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>q<CR>', { buffer = true, silent = true })
  end,
})

-- Text files (Markdown, TeX, Text)
api.nvim_create_autocmd("FileType", {
  group = text_group,
  pattern = { "markdown", "tex", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
    vim.cmd([[ hi SpellBad cterm=underline ]])
  end,
})

-- LaTeX specific
api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    local opts = { buffer = true, silent = true }

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
    vim.keymap.set("v", "<leader>e",
      "'<,'>s/\\%V\\_.*\\%V./\\t\\\\begin{enumerate}[label=(\\\\arabic*)]^M&^M\\t\\\\end{enumerate}/g | '<,'>s/(\\d*)/\\\\item/g",
      opts)
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
  pattern = "python",
  callback = function()
    vim.opt_local.foldmethod = 'indent'
    vim.opt_local.foldlevel = 99
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = 'unix'
    vim.opt_local.formatoptions:remove("t")
  end,
})

-- Disable spell for specific filetypes
api.nvim_create_autocmd("FileType", {
  pattern = { "conf", "gas" },
  callback = function()
    vim.cmd([[hi clear SpellBad]])
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.todo",
  callback = function()
    vim.bo.filetype = "todo"
  end,
})

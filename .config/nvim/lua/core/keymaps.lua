local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

-- Disable ; in normal mode
keymap("", ";", "<Nop>", opts)

-- Save
keymap("n", "<C-s>", ":update<CR>", opts)
keymap("i", "<C-s>", "<Esc>:update<CR>a", opts)

-- Escape alternatives
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)

-- Window navigation
keymap("n", "H", "<C-W><C-H>", opts)
keymap("n", "L", "<C-W><C-L>", opts)
keymap("n", "J", "<C-W><C-j>", opts)
keymap("n", "K", "<C-W><C-k>", opts)

-- Terminal
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
keymap("n", "<C-T>", ":split term://zsh<CR>", opts)

-- Tab navigation
keymap("n", "<C-j>", "gT", opts)
keymap("n", "<C-k>", "gt", opts)

-- Movement improvements
keymap({ "n", "v" }, "k", "gk", opts)
keymap({ "n", "v" }, "j", "gj", opts)
keymap("o", "j", "gj", opts)
keymap("o", "k", "gk", opts)
keymap({ "n", "v" }, "0", "g0", opts)
keymap({ "n", "v" }, "$", "g$", opts)
keymap({ "n", "v" }, "^", "g^", opts)

-- Format line
keymap({ "n", "v" }, "gk", "==gqq", opts)

-- Better delete (don't yank)
keymap("n", "d", '"_d', opts)

-- File operations
keymap("n", "gF", "<C-w>gf", opts)
keymap("n", "<leader>gf", ":e <cfile><CR>", opts)

-- Clipboard operations
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+yg_', opts)
keymap("n", "<leader>y", '"+y', opts)
keymap("n", "<leader>yy", '"+yy', opts)
keymap("n", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("v", "<leader>P", '"+P', opts)

-- Clear search highlight
keymap("n", "c/", ":nohlsearch<CR>", opts)

-- Spellcheck (quick fix)
keymap("i", "<C-l>", "<c-g>u<Esc>:nohlsearch<CR>[s1z=`]a<c-g>u", opts)
keymap("n", "<C-l>", "i<c-g>u<Esc>:nohlsearch<CR>[s1z=`]a<c-g>u<Esc>", opts)

-- Plugin-specific keymaps (will be overridden by plugin configs)
-- File explorer
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", opts)

-- Git conflict markers
keymap("n", "cx", ":ConflictMarkerBoth<CR>", opts)
keymap("n", "cX", ":ConflictMarkerBoth!<CR>", opts)

-- Fugitive
keymap("n", "<leader>gd", ":Gvdiff<CR>", opts)
keymap("n", "gdh", ":diffget //2<CR>", opts)
keymap("n", "gdl", ":diffget //3<CR>", opts)
keymap("n", "gdp", ":diffput<CR>", opts)

-- Indent guides
keymap("n", "<leader>r", ":IndentGuidesToggle<CR>", opts)

-- C/C++ header guards
keymap('n', '<leader>ig', function()
  local base = vim.fn.expand("%:t:r")
  local filename = vim.fn.expand("%:t:r"):upper():gsub("[^A-Z0-9]", "_")
  local hpp_guard = "__" .. filename .. "_HPP__"
  local hxx_guard = "__" .. filename .. "_HXX__"

  vim.api.nvim_buf_set_lines(0, 0, 0, false, {
    "#ifndef " .. hpp_guard,
    "#define " .. hpp_guard,
    ""
  })

  local line_count = vim.api.nvim_buf_line_count(0)
  vim.api.nvim_buf_set_lines(0, line_count, line_count, false, {
    "",
    "#endif // " .. hpp_guard,
    "",
    "#ifndef " .. hxx_guard,
    '#include "impl/' .. base .. '.hxx"',
    "#endif // " .. hxx_guard,
    ""
  })
end, { desc = "Add include guards" })

keymap('n', '<leader>ih', function()
  local base = vim.fn.expand("%:t:r")
  local filename = vim.fn.expand("%:t:r"):upper():gsub("[^A-Z0-9]", "_")
  local hxx_guard = "__" .. filename .. "_HXX__"
  local hpp_guard = "__" .. filename .. "_HPP__"

  vim.api.nvim_buf_set_lines(0, 0, 0, false, {
    "#ifndef " .. hxx_guard,
    "#define " .. hxx_guard,
    "",
    "#ifndef " .. hpp_guard,
    '#include "../' .. base .. '.hpp"',
    "#endif // " .. hpp_guard,
    ""
  })

  local line_count = vim.api.nvim_buf_line_count(0)
  vim.api.nvim_buf_set_lines(0, line_count, line_count, false, {
    "",
    "#endif // " .. hxx_guard
  })
end, { desc = "Add HXX header guard + HPP check" })

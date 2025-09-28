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

-- Aerial
keymap("n", "<leader>a", ":AerialToggle!<CR>", opts)

-- CTags
keymap("n", "<C-F12>", ":!ctags -R -f ./.git/tags .<CR>", opts)

local api = vim.api
local cmd = vim.cmd
local set = vim.opt
local g   = vim.g

local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

local map = M.map

-- Leader key to ; -------
map("", ";", "<Nop>", { noremap = true, silent = true })
g.mapleader = ";"
g.maplocalleader = ";"

-- ctrlp -----------------
map("n", "<C-F12>", ":!ctags -R -f ./.git/tags .<CR>")

-- NERDTree --------------
map("n", "<C-n>", ":NvimTreeToggle<CR>")
map("n", "<leader>n", ":NvimTreeToggle<CR>")

-- Ranger ----------------
-- map("", "<leader>r", ":Ranger<CR>")

-- Indents ---------------
map("n", "<leader>r", ':IndentGuidesToggle<CR>')

-- NERDTree --------------
map("n", "<leader>g", ":GitGutterToggle<CR>")


map("n", "gF", "<c-w>gf")

-- Save ------------------
map("n", "<C-s>", ":up<CR>")
map("i", "<C-s>", "<esc><C-s>a")

-- Escape maps -----------
map("i", "jk", "<esc>")
map("i", "kj", "<esc>")

-- splits ----------------
map("n", "H", "<C-W><C-H>")
map("n", "L", "<C-W><C-L>")
map("n", "<C-j>", "<C-W><C-j>")
map("n", "<C-k>", "<C-W><C-k>")

-- tabs ------------------
map("n", "J", "gT")
map("n", "K", "gt")

-- fugitive --------------
map("n", "<leader>gd", ":Gvdiff<CR>")
map("n", "gdh", ":diffget //2<CR>")
map("n", "gdl", ":diffget //3<CR>")
map("n", "gdp", ":diffput<CR>")

-- macros ----------------
map("", "k", "gk", { silent = true })
map("", "j", "gj", { silent = true })
map("o", "j", "gj", { silent = true })
map("o", "k", "gk", { silent = true })

map("", "0", "g0", { silent = true })
map("", "$", "g$", { silent = true })
map("", "^", "g^", { silent = true })
map("", "gk", "==gqq", { silent = true })
-- map("", "gK", "=%", { silent = true })

-- delete tweak ----------
map("n", "d", '"_d')

-- open file ------------
map("n", "<leader>gf", ":e <cfile><cr>")

-- -- formatting ------------

-- paragraph tools -------
map("n", "gj", "vipgq")
map("n", "fj", "vipJ")

-- disabling arrows ------
-- map("i", "<Up>", "<Nop>")
-- map("i", "<Right>", "<Nop>")
-- map("i", "<Left>", "<Nop>")
-- map("i", "<Down>", "<Nop>")

-- copy to clipboard -----
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>y", '"+y')
map("n", "<leader>yy", '"+yy')

-- paste to clipboard ----
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>P", '"+P')

-- spellcheck ------------
map("i", "<C-l>", "<c-g>u<Esc>:nohl<CR>[s1z=`]a<c-g>u")
map("n", "<C-l>", "i<c-g>u<Esc>:nohl<CR>[s1z=`]a<c-g>u<Esc>")


return M


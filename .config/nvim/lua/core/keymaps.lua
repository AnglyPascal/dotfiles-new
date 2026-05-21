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

-- ─── Plugin keymaps ───────────────────────────────────────────────────────────

-- File explorer
keymap("n", "<C-n>",     "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
keymap("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

-- Telescope
keymap("n", "<C-p>", function()
  require("telescope.builtin").git_files({ show_untracked = true })
end, { desc = "Git files (incl. untracked/hidden)" })
keymap("n", "<C-S-p>", function()
  require("telescope.builtin").find_files({
    hidden = true,
    find_command = {
      "rg", "--files", "--hidden", "--no-ignore",
      "--glob", "!**/.git/*", "--glob", "!**/node_modules/*",
      "--glob", "!**/_deps/*", "--glob", "!**/CMakeFiles/*",
    },
  })
end, { desc = "All files (no gitignore, incl. hidden)" })
keymap("n", "<leader>/", function()
  require("telescope.builtin").live_grep({ additional_args = { "--hidden", "--glob", "!.git/" } })
end, { desc = "Live grep (incl. hidden files)" })
keymap("n", "<leader>?", function()
  require("telescope.builtin").live_grep({ additional_args = { "--hidden", "--no-ignore", "--glob", "!.git/" } })
end, { desc = "Ripgrep all files (no gitignore)" })
keymap("n", "<leader>]",  "<cmd>Telescope resume<cr>",    { desc = "Resume telescope" })
keymap("n", "<leader>b",  "<cmd>Telescope buffers<cr>",   { desc = "Find buffers" })
keymap("n", "<leader>gh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>gg", "<cmd>Telescope git_files<cr>", { desc = "Git files" })

-- Indent guides
keymap("n", "<leader>r", "<cmd>IBLToggle<cr>", { desc = "Toggle indent guides" })

-- Conflict markers
keymap("n", "co", "<cmd>ConflictMarkerOurselves<cr>",  { desc = "Conflict: take ours" })
keymap("n", "ct", "<cmd>ConflictMarkerThemselves<cr>", { desc = "Conflict: take theirs" })
keymap("n", "cb", "<cmd>ConflictMarkerBoth<cr>",       { desc = "Conflict: take both (ours first)" })
keymap("n", "cB", "<cmd>ConflictMarkerBoth!<cr>",      { desc = "Conflict: take both (theirs first)" })
keymap("n", "cn", "<cmd>ConflictMarkerNone<cr>",       { desc = "Conflict: take neither" })
keymap("n", "]x", "<cmd>ConflictMarkerNextHunk<cr>",   { desc = "Next conflict" })
keymap("n", "[x", "<cmd>ConflictMarkerPrevHunk<cr>",   { desc = "Prev conflict" })

-- Code outline
keymap("n", "<leader>a", "<cmd>AerialToggle!<cr>", { desc = "Toggle aerial" })

-- Find and replace
keymap("n", "<leader>S",  function() require("spectre").toggle() end,                                { desc = "Toggle Spectre" })
keymap("n", "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end,     { desc = "Spectre: search word" })
keymap("n", "<leader>sp", function() require("spectre").open_file_search({ select_word = true }) end, { desc = "Spectre: search in file" })

-- Checkmate (todo lists)
keymap("n", "<leader>tn", "<cmd>Checkmate create<cr>", { desc = "New checkbox" })
keymap("n", "<leader>tt", "<cmd>Checkmate toggle<cr>", { desc = "Toggle checkbox" })

-- Format buffer
keymap("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- Git: Fugitive
keymap("n", "<leader>gd", "<cmd>Gdiffsplit<cr>",  { desc = "Git diff" })
keymap("n", "gdh",        "<cmd>diffget //2<cr>", { desc = "Get left diff" })
keymap("n", "gdl",        "<cmd>diffget //3<cr>", { desc = "Get right diff" })
keymap("n", "gdp",        "<cmd>diffput<cr>",     { desc = "Put diff" })

-- Git: Diffview
keymap("n", "<leader>gv", "<cmd>DiffviewOpen<cr>",          { desc = "Diffview open" })
keymap("n", "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview file history" })
keymap("n", "<leader>gq", "<cmd>DiffviewClose<cr>",         { desc = "Diffview close" })

-- Git: Gitsigns
keymap("n", "<leader>g", function() require("gitsigns").toggle_numhl() end, { desc = "Toggle git num highlights" })
keymap("n", "]h",         function() require("gitsigns").nav_hunk("next") end, { desc = "Next git hunk" })
keymap("n", "[h",         function() require("gitsigns").nav_hunk("prev") end, { desc = "Prev git hunk" })
keymap("n", "<leader>hp", function() require("gitsigns").preview_hunk() end,              { desc = "Preview hunk" })
keymap("n", "<leader>hr", function() require("gitsigns").reset_hunk() end,                { desc = "Reset hunk" })
keymap("n", "<leader>hs", function() require("gitsigns").stage_hunk() end,                { desc = "Stage hunk" })
keymap("n", "<leader>hu", function() require("gitsigns").stage_hunk({ undo = true }) end, { desc = "Undo stage hunk" })

-- Molten (Jupyter / Python REPL)
keymap("n", "<leader>li", "<cmd>MoltenInit python3<CR>",               { desc = "Molten: init" })
keymap("n", "<leader>ll", "<cmd>MoltenEvaluateLine<CR>",               { desc = "Molten: evaluate line" })
keymap("v", "<leader>ll", ":<C-u>MoltenEvaluateVisual<CR>gv",          { desc = "Molten: evaluate visual" })
keymap("n", "<leader>lr", "<cmd>MoltenReevaluateCell<CR>",             { desc = "Molten: re-evaluate cell" })
keymap("n", "<leader>la", "<cmd>MoltenReevaluateAll<CR>",              { desc = "Molten: re-evaluate all" })
keymap("n", "<leader>lo", "<cmd>MoltenShowOutput<CR>",                 { desc = "Molten: show output" })
keymap("n", "<leader>lh", "<cmd>MoltenHideOutput<CR>",                 { desc = "Molten: hide output" })
keymap("n", "<leader>ld", "<cmd>MoltenDelete<CR>",                     { desc = "Molten: delete cell" })
keymap("n", "<leader>lx", "<cmd>MoltenInterrupt<CR>",                  { desc = "Molten: interrupt" })
keymap("n", "<leader>lk", "<cmd>MoltenInfo<CR>",                       { desc = "Molten: info" })
keymap("n", "<leader>lq", "<cmd>MoltenDeinit<CR>",                     { desc = "Molten: quit kernel" })


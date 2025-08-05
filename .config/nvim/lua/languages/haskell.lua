local api = vim.api

-- Haskell settings
vim.g.ale_haskell_ghc_options = '-dynamic'
vim.g.hindent_on_save = 0

-- Haskell-specific autocmd
api.nvim_create_autocmd("FileType", {
  pattern = "haskell",
  callback = function()
    local bufnr = api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Formatting
    vim.keymap.set("n", "<leader>f", ":Hindent<cr>", opts)
  end,
})

-- Additional Haskell plugins that would be loaded with this config
-- Add these to your plugins if you uncomment this language:
--
-- {
--   "neovimhaskell/haskell-vim",
--   ft = "haskell",
-- },
-- {
--   "alx741/vim-hindent",
--   ft = "haskell",
-- },
-- {
--   "alx741/vim-stylishask",
--   ft = "haskell",
-- },
--

-- Legacy ALE for haskell linting
-- {
--   "dense-analysis/ale",
--   ft = { "haskell" },
--   cmd = "ALEEnable",
--   config = function()
--     vim.g.ale_echo_msg_error_str = "E"
--     vim.g.ale_echo_msg_warning_str = "W"
--     vim.g.ale_sign_error = "E"
--     vim.g.ale_sign_warning = "W"
--     vim.g.ale_open_list = 0
--     vim.g.ale_loclist = 0

--     vim.g.ale_linters = {
--       haskell = { "ghc", "hlint" },
--     }

--     vim.g.ale_fixers = {
--       haskell = { "stylish-haskell" },
--     }

--     vim.g.ale_haskell_ghc_options = "-fno-code -v0 -dynamic"

--     vim.cmd([[ALEEnable]])
--   end,
-- },

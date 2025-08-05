local api = vim.api

-- Java-specific autocmds
api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local bufnr = api.nvim_get_current_buf()
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Compilation shortcuts
    vim.keymap.set("i", ";ll", ":!javac %;f=%; java ${f%.*}<cr>", opts)
    vim.keymap.set("n", ";ll", ":!javac %;f=%; java ${f%.*}<cr>", opts)
  end,
})

-- Additional Java plugins that would be loaded with this config:
-- Add these to your plugins if you uncomment this language:
--
-- {
--   "mfussenegger/nvim-jdtls",
--   ft = "java",
--   config = function()
--     -- JDTLS configuration would go here
--   end,
-- },

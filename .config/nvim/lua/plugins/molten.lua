return {
  "benlubas/molten-nvim",
  version = "^1.0.0",
  build = ":UpdateRemotePlugins",
  dependencies = { "3rd/image.nvim" },

  init = function()
    vim.g.molten_output_win_max_height = 20
    vim.g.molten_auto_open_output = false
    vim.g.molten_wrap_output = true
    vim.g.molten_virt_text_output = true
    vim.g.molten_virt_lines_off_by_1 = true
  end,

  config = function()
    -- Initialize kernel
    vim.keymap.set("n", "<leader>li", ":MoltenInit python3<CR>", { desc = "Initialize Molten" })

    -- Evaluate
    vim.keymap.set("n", "<leader>ll", ":MoltenEvaluateLine<CR>", { desc = "Evaluate line" })
    vim.keymap.set("v", "<leader>ll", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual" })
    vim.keymap.set("n", "<leader>lr", ":MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
    vim.keymap.set("n", "<leader>la", ":MoltenReevaluateAll<CR>", { desc = "Re-evaluate all" })

    -- Output
    vim.keymap.set("n", "<leader>lo", ":MoltenShowOutput<CR>", { desc = "Show output" })
    vim.keymap.set("n", "<leader>lh", ":MoltenHideOutput<CR>", { desc = "Hide output" })

    -- Delete/interrupt
    vim.keymap.set("n", "<leader>ld", ":MoltenDelete<CR>", { desc = "Delete cell" })
    vim.keymap.set("n", "<leader>lx", ":MoltenInterrupt<CR>", { desc = "Interrupt execution" })

    -- Kernel management
    vim.keymap.set("n", "<leader>lk", ":MoltenInfo<CR>", { desc = "Molten info" })
    vim.keymap.set("n", "<leader>lq", ":MoltenDeinit<CR>", { desc = "Quit kernel" })
  end,
}

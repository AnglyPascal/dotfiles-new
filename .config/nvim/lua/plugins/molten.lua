return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    ft = "python",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    keys = {
      { "<leader>li", "<cmd>MoltenInit python3<CR>",                    desc = "Initialize Molten" },
      { "<leader>ll", "<cmd>MoltenEvaluateLine<CR>",                    desc = "Evaluate line" },
      { "<leader>ll", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v",  desc = "Evaluate visual" },
      { "<leader>lr", "<cmd>MoltenReevaluateCell<CR>",                  desc = "Re-evaluate cell" },
      { "<leader>la", "<cmd>MoltenReevaluateAll<CR>",                   desc = "Re-evaluate all" },
      { "<leader>lo", "<cmd>MoltenShowOutput<CR>",                      desc = "Show output" },
      { "<leader>lh", "<cmd>MoltenHideOutput<CR>",                      desc = "Hide output" },
      { "<leader>ld", "<cmd>MoltenDelete<CR>",                          desc = "Delete cell" },
      { "<leader>lx", "<cmd>MoltenInterrupt<CR>",                       desc = "Interrupt execution" },
      { "<leader>lk", "<cmd>MoltenInfo<CR>",                            desc = "Molten info" },
      { "<leader>lq", "<cmd>MoltenDeinit<CR>",                          desc = "Quit kernel" },
    },
    init = function()
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },
}

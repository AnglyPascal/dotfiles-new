return {
  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gvdiff", "Gwrite", "Gread" },
    keys = {
      { "<leader>gd", "<cmd>Gvdiff<cr>", desc = "Git diff" },
      { "gdh", "<cmd>diffget //2<cr>", desc = "Get left diff" },
      { "gdl", "<cmd>diffget //3<cr>", desc = "Get right diff" },
      { "gdp", "<cmd>diffput<cr>", desc = "Put diff" },
      { "<leader>/", ":Git grep -q ", desc = "Git grep" },
    },
  },

  -- Git gutter (modern alternative: gitsigns.nvim)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>g", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle git signs" },
      { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next git hunk" },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous git hunk" },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
    },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
        current_line_blame = false,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  },
}

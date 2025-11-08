return {
  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gdiffsplit", "Gwrite", "Gread" },
    keys = {
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff" },
      { "gdh", "<cmd>diffget //2<cr>", desc = "Get left diff" },
      { "gdl", "<cmd>diffget //3<cr>", desc = "Get right diff" },
      { "gdp", "<cmd>diffput<cr>", desc = "Put diff" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,  -- load eagerly so it's available
    keys = {
      {
        "<leader>g",
        function()
          local gs = package.loaded.gitsigns
          if gs then
            if gs.toggle_signs then
              gs.toggle_signs()
            else
              vim.notify("Gitsigns is not initialized", vim.log.levels.WARN)
            end
          else
            require("gitsigns").setup()
          end
        end,
        desc = "Toggle git signs",
      },
      { "]h", function() require("gitsigns").nav_hunk("next") end, desc = "Next git hunk" },
      { "[h", function() require("gitsigns").nav_hunk("prev") end, desc = "Previous git hunk" },
      { "<leader>hp",
        function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
      { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
      { "<leader>hs",
        function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
      { "<leader>hu", function() require("gitsigns").stage_hunk({ undo = true }) end, desc = "Undo stage hunk" },
    },
    config = function()
      -- Only configure but don't activate gitsigns initially
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
        signs_staged = {
          add = { text = "+|" },
          change = { text = "~|" },
          delete = { text = "-|" },
          topdelete = { text = "-|" },
          changedelete = { text = "~|" },
        },

        signcolumn = false,         -- don't show signs initially
        numhl = false,              -- turn off number highlighting
        linehl = true,
        word_diff = false,
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

      -- Immediately disable signs after setup
      require("gitsigns").toggle_signs(false)
    end,
  },
}

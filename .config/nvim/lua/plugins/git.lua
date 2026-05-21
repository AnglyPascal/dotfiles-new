return {
  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "Gdiffsplit", "Gwrite", "Gread" },
  },

  -- Side-by-side diffs and file history
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      -- Only configure but don't activate gitsigns initially
      require("gitsigns").setup({
        signs              = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "-" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
        signs_staged       = {
          add = { text = "+|" },
          change = { text = "~|" },
          delete = { text = "-|" },
          topdelete = { text = "-|" },
          changedelete = { text = "~|" },
        },

        signcolumn         = false,
        numhl              = false,
        linehl             = false,
        word_diff          = false,
        current_line_blame = false,
        sign_priority      = 6,
        update_debounce    = 100,
        status_formatter   = nil,
        max_file_length    = 40000,
        preview_config     = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })

      -- Number-column highlight colors (re-applied after any :colorscheme reload)
      local function set_hl()
        local hl = vim.api.nvim_set_hl
        -- unstaged
        hl(0, "GitSignsAddNr", { fg = "#a6e3a1", bg = "#1e3a2f" })
        hl(0, "GitSignsChangeNr", { fg = "#f9e2af", bg = "#3a2e14" })
        hl(0, "GitSignsDeleteNr", { fg = "#f38ba8", bg = "#3a1a1c" })
        hl(0, "GitSignsTopDeleteNr", { fg = "#f38ba8", bg = "#3a1a1c" })
        hl(0, "GitSignsChangeDeleteNr", { fg = "#f9e2af", bg = "#3a1a1c" })
        -- staged (fg only)
        hl(0, "GitSignsStagedAddNr",          { fg = "#a6e3a1" })
        hl(0, "GitSignsStagedChangeNr",        { fg = "#f9e2af" })
        hl(0, "GitSignsStagedDeleteNr",        { fg = "#f38ba8" })
        hl(0, "GitSignsStagedTopDeleteNr",     { fg = "#f38ba8" })
        hl(0, "GitSignsStagedChangeDeleteNr",  { fg = "#f9e2af" })
      end
      set_hl()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
    end,
  },
}

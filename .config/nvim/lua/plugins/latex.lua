return {
  -- VimTeX for LaTeX support
  {
    "lervag/vimtex",
    ft = { "tex", "latex" },
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_automatic = 0
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_syntax_custom_cmds = {
        { name = "agc", env = 1, verbatim = 1 },
      }
      vim.g.vimtex_delim_toggle_mod_list = {
        { "\\bigl", "\\bigr" },
        { "\\Bigl", "\\Bigr" },
        { "\\left", "\\right" },
      }
    end,
  },

  -- LaTeX formatter
  {
    "anglypascal/vim-latexfmt",
    ft = { "tex", "latex" },
  },

  -- Snippets
  {
    "SirVer/ultisnips",
    ft = { "tex", "plaintex", "latex" },
    dependencies = { "honza/vim-snippets" },
  },

}

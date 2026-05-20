return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("config.lsp")
    end,
  },

  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          ensure_installed = {
            "clangd",
            "bash-language-server",
            "css-lsp",
            "json-lsp",
            "lua-language-server",
            "pyright",
            "rust-analyzer",
            "typescript-language-server",
            "yaml-language-server",
          },
        },
      })
    end,
  },
}

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "yapf" },
        c      = { "clang_format" },
        cpp    = { "clang_format" },
      },
      -- for everything else (rust, go, ts...) fall back to the LSP formatter
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
  },
}

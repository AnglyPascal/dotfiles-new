return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
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

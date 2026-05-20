return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "default",
        -- When menu is closed, fall through so UltiSnips can expand on Tab
        ["<Tab>"]   = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        sources = { "path", "cmdline" },
      },
      snippets = { preset = "default" },
      completion = {
        documentation = { auto_show = false },
      },
    },
  },
}

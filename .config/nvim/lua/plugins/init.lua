-- Setup lazy.nvim
require("lazy").setup({
  -- Load plugin groups
  { import = "plugins.editor" },
  { import = "plugins.ui" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.git" },
  { import = "plugins.treesitter" },
  { import = "plugins.latex" },
  { import = "plugins.languages" },
}, {
  -- Lazy.nvim configuration
  defaults = {
    lazy = true, -- Enable lazy loading by default
  },
  install = {
    colorscheme = { "bestblack", "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

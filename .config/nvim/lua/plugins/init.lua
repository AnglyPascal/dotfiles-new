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

vim.keymap.set("n", "<leader>[", function()
  require("telescope.builtin").find_files({
    find_command = {
      "rg",
      "--files",
      "--no-ignore",
      "--hidden",
      "--glob", "!**/_deps/*",
      "--glob", "!**/third_party/*",
      "--glob", "!**/CMakeFiles/*",
    },
  })
end, { desc = "Find files (ignore .gitignore, exclude _deps)" })

return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "OXY2DEV/markview.nvim",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "cpp", "lua", "python", "javascript", "typescript",
          "rust", "scala", "ocaml", "bash", "vim", "vimdoc",
          "markdown", "json", "yaml", "toml", "html", "css",
          -- intentionally NOT including "latex"
        },
        ignore_install = { "latex" }, -- don't even attempt to install the latex parser
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "latex" },                           -- disable Tree-sitter highlighting for latex
          additional_vim_regex_highlighting = { "latex" }, -- let VimTeX handle highlighting
        },
        indent = {
          enable = true,
          disable = { "latex" }, -- optional: Tree-sitter indentation can also break VimTeX
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
}

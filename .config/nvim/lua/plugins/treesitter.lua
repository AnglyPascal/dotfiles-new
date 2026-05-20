return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        -- install_dir is optional; defaults to stdpath("data")/site
      })

      -- Install parsers (async). Only runs missing ones.
      require("nvim-treesitter").install({
        "c", "cpp", "lua", "python", "javascript", "typescript", "tsx",
        "rust", "scala", "ocaml", "bash", "vim", "vimdoc",
        "markdown", "markdown_inline", "json", "yaml", "toml", "html", "css",
      })

      -- Enable highlighting + indent per filetype.
      -- The main branch does NOT auto-enable these; you must do it yourself.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype
          if ft == "latex" then return end

          -- Map filetype -> parser language if they differ
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then return end

          -- Only start if parser is installed
          if not pcall(vim.treesitter.start, buf, lang) then return end

          -- Folding via treesitter (optional)
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"

          -- Indent via treesitter
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    opts = {
      markdown = {
        list_items = { enable = false },
        headings = { shift_width = 0 },
      },
    },
  },
}

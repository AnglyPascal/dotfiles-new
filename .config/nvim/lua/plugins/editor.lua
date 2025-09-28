return {
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    keys = {
      { "<C-n>",     "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
      { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom mappings
        vim.keymap.set('n', 'v', api.node.open.horizontal, opts('horizontal split'))
        vim.keymap.set('n', 's', api.node.open.vertical, opts('vertical split'))
        vim.keymap.set("n", "<c-o>", api.node.run.system, opts("Run System"))
        vim.keymap.set('n', 't', api.node.open.tab, opts('open in tab'))
        vim.keymap.set("n", "L", "<C-W><C-L>", opts('move to right'))
      end

      require("nvim-tree").setup({
        sort = { sorter = "filetype" },
        view = {
          width = 30,
          relativenumber = true,
        },
        on_attach = my_on_attach,
        renderer = {
          group_empty = true,
          symlink_destination = false,
        },
        filters = {
          dotfiles = true,
          custom = { 'node_modules', '*.o', '*.a' },
        },
      })
    end,
  },

  -- Fuzzy finder (modern replacement for CtrlP)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<C-p>",      "<cmd>Telescope find_files<cr>",  desc = "Find files" },
      { "<leader>/",  "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
      { "<leader>?",  "<cmd>Telescope grep_string<cr>", desc = "Grep string" },
      { "<leader>b",  "<cmd>Telescope buffers<cr>",     desc = "Find buffers" },
      { "<leader>gh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
      { "<leader>gg", "<cmd>Telescope git_files<cr>",   desc = "Git files" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "%.git/", "node_modules/", "%.aux", "%.log", "%.pdf", "%.pyc", "%.o",
            "%.ggb", "%.ilg", "%.ind", "%.fls", "%.out", "%.synctex.gz",
            "%.idx", "%.ggt", "%.pdf_tex", "%.fdb_latexmk", "%.blg", "%.class",
            "%.bbl", "%.toc", "%.xdv", "%.ent", "dist/", "target/", "%.bloop/", "%.metals/"
          },
          mappings = {
            i = {
              ["jk"] = actions.close,
              ["kj"] = actions.close,
            },
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },

  -- Auto-pairs (modern replacement)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Auto-save
  {
    "907th/vim-auto-save",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Commentary
  {
    "tpope/vim-commentary",
    keys = {
      { "gc",  mode = { "n", "v" } },
      { "gcc", mode = "n" },
    },
  },

  -- Surround
  {
    "tpope/vim-surround",
    keys = { "cs", "ds", "ys" },
  },

  -- Indent guides
  {
    "nathanaelkane/vim-indent-guides",
    cmd = "IndentGuidesToggle",
    keys = {
      { "<leader>r", "<cmd>IndentGuidesToggle<cr>", desc = "Toggle indent guides" },
    },
  },

  -- Conflict markers
  {
    "rhysd/conflict-marker.vim",
    event = "BufReadPost",
    keys = {
      { "cx", "<cmd>ConflictMarkerBoth<cr>",  desc = "Take both sides" },
      { "cX", "<cmd>ConflictMarkerBoth!<cr>", desc = "Take both sides (reverse)" },
    },
  },

  -- Snippets
  {
    "SirVer/ultisnips",
    event = "InsertEnter",
    dependencies = { "honza/vim-snippets" },
  },

  -- Alignment
  {
    "godlygeek/tabular",
    cmd = { "Tabularize", "Tab" },
  },

  -- Code outline/symbols
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "AerialToggle", "AerialOpen" },
    keys = {
      { "<leader>a", "<cmd>AerialToggle!<cr>", desc = "Toggle aerial" },
    },
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
    end,
  },

  -- Grammar checking
  {
    "rhysd/vim-grammarous",
    ft = { "tex", "text", "markdown" },
    cmd = { "GrammarousCheck", "GrammarousReset" },
  },

  -- Color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- HTTP client
  {
    "aquach/vim-http-client",
    ft = { "http", "rest" },
  },

  -- Spectre for find/replace
  {
    'nvim-pack/nvim-spectre',
    lazy = false,
    config = function()
      require('spectre').setup({
        default = {
          find = {
            cmd = "rg",
            options = { "--ignore-case" }
          }
        }
      })
    end,
    keys = {
      { "<leader>S",  '<cmd>lua require("spectre").toggle()<CR>',                             desc = "Toggle Spectre" },
      { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',      desc = "Search current word" },
      { "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search in current file" },
    }
  },
}

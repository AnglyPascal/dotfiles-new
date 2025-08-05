return {
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
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
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "%.git/", "node_modules/", "%.aux", "%.log", "%.pdf", "%.pyc", "%.o",
            "%.ggb", "%.ilg", "%.ind", "%.fls", "%.out", "%.synctex.gz",
            "%.idx", "%.ggt", "%.pdf_tex", "%.fdb_latexmk", "%.blg", "%.class",
            "%.bbl", "%.toc", "%.xdv", "%.ent", "dist/", "target/", "%.bloop/", "%.metals/"
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
      { "gc", mode = { "n", "v" } },
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
      { "cx", "<cmd>ConflictMarkerBoth<cr>", desc = "Take both sides" },
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
}

local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { 
      "wbthomason/packer.nvim", 
      opt = true 
    }

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip" },
      },
    }

    -- Accessories
    use 'sirver/ultisnips'
    use '907th/vim-auto-save' 
    use 'kien/ctrlp.vim'
    use 'tpope/vim-commentary'
    use 'sheerun/vim-polyglot'

    use 'nathanaelkane/vim-indent-guides'
    use {
      'rhysd/vim-grammarous',
      ft = {'tex', 'text', 'markdown'},
    }
    use 'rhysd/conflict-marker.vim'
    -- use {
    --   "windwp/nvim-autopairs",
    --     config = function() require("nvim-autopairs").setup {} end
    -- }
    
    use { 
      'jiangmiao/auto-pairs',
      -- ft = {
      --   'python', 'java', 'javascript', 'haskell', 
      --   'scala', 'html', 'lua', 'ocaml', 'c', 'cpp'
      -- },
    }
    
    use {
      'w0rp/ale',
      ft = {'python', 'java', 'javascript', 'haskell', 'cpp'},
      cmd = 'ALEEnable',
      config = 'vim.cmd[[ALEEnable]]'
    }
    use 'tpope/vim-surround'

    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
    }

    -- Color schemes
    use 'norcalli/nvim-colorizer.lua'

    -- Statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
    }

    -- Python
    use { 
      'vim-scripts/indentpython.vim',
      ft = {'python'},
    }

    -- Git
    use 'tpope/vim-fugitive'
    use {
      'airblade/vim-gitgutter',
      cmd = 'GitGutterToggle'
    }

    -- Alignment
    use 'godlygeek/tabular'

    -- Java
    -- use 'uiiaoo/java-syntax.vim'
    -- use 'roxma/vim-hug-neovim-rpc'
    
    -- Add maktaba and codefmt to the runtimepath.
    -- (The latter must be installed before it can be used.)
    use 'google/vim-maktaba'
    use 'google/vim-codefmt'
    -- use 'google/vim-glaive'
    -- vim.cmd([[ 
    --   call glaive#Install()
    --   " Optional: Enable codefmt's default mappings on the <Leader>= prefix.
    --   Glaive codefmt plugin[mappings]
    -- ]])
    

    -- Scala
    use "scalameta/nvim-metals"

    -- Debugging
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'

    -- JavaScript
    -- use 'posva/vim-vue'
    -- use 'maksimr/vim-jsbeautify'
    use 'maxmellon/vim-jsx-pretty'
    use 'neoclide/vim-jsx-improve'
    use 'pangloss/vim-javascript'
    -- use 'diepm/vim-rest-console'
    use 'aquach/vim-http-client'

    -- coc
    use {
      'neoclide/coc.nvim',
      branch = 'release',
      ft = {
        'javascript', 
        'javascriptreact', 
        'typescript', 
        'typescriptreact', 
        'ocaml',
        'c',
        'cpp',
        'rust'
      },
    }

    -- Rust
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'

    -- ANTLR
    -- use { 'dylon/vim-antlr' }
    --

    -- C++
    use { 'bfrg/vim-cpp-modern' }
    use { 'rhysd/vim-clang-format' }

    -- Assembly
    use { 'shirk/vim-gas' }
    use { 'kylelaker/riscv.vim' }

    -- TypeScript
    -- use 'HerringtonDarkholme/yats.vim'

    -- Haskell
    -- use 'khardix/vim-literate'
    -- use 'neovimhaskell/haskell-vim'
    -- use 'alx741/vim-hindent'
    -- use 'alx741/vim-stylishask'
    -- use 'neovimhaskell/haskell-vim'

    -- -- Lua
    -- use 'tjdevries/nlua.nvim'
    -- use 'euclidianAce/BetterLua.vim'

    -- latex
    vim.g.latexfmt_no_join_any = { 
      '\\ifextraC', '\\ifextraA', '\\ifextraB', '\\fi', '\\else' 
    }

    use 'anglypascal/vim-latexfmt'
    -- use 'lervag/vimtex'

    use { 'lervag/vimtex',
      vim.cmd([[
        let g:vimtex_view_method = 'zathura'
        let g:vimtex_view_automatic = 0
        let g:vimtex_quickfix_open_on_warning = 0
        ]])
     }

    use 'instant-markdown/vim-instant-markdown'

    -- -- R
    -- use 'jalvesaq/Nvim-R'
    
    use {
      "stevearc/aerial.nvim",
      requires = { 
        {"nvim-treesitter/nvim-treesitter"},
      }
    }
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M

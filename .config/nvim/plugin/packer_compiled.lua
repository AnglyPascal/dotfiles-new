-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/ahsan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/ahsan/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/ahsan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/ahsan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ahsan/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["BetterLua.vim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/BetterLua.vim",
    url = "https://github.com/euclidianAce/BetterLua.vim"
  },
  ["Nvim-R"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/Nvim-R",
    url = "https://github.com/jalvesaq/Nvim-R"
  },
  ale = {
    commands = { "ALEEnable" },
    config = { "vim.cmd[[ALEEnable]]" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/opt/ale",
    url = "https://github.com/w0rp/ale"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["coc.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/opt/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["ctrlp.vim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/ctrlp.vim",
    url = "https://github.com/kien/ctrlp.vim"
  },
  ["haskell-vim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/haskell-vim",
    url = "https://github.com/neovimhaskell/haskell-vim"
  },
  ["indentpython.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/opt/indentpython.vim",
    url = "https://github.com/vim-scripts/indentpython.vim"
  },
  ["java-syntax.vim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/java-syntax.vim",
    url = "https://github.com/uiiaoo/java-syntax.vim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nlua.nvim",
    url = "https://github.com/tjdevries/nlua.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-metals"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nvim-metals",
    url = "https://github.com/scalameta/nvim-metals"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  tabular = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ultisnips = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/sirver/ultisnips"
  },
  ["vim-auto-save"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-auto-save",
    url = "https://github.com/907th/vim-auto-save"
  },
  ["vim-clang-format"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-clang-format",
    url = "https://github.com/rhysd/vim-clang-format"
  },
  ["vim-codefmt"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-codefmt",
    url = "https://github.com/google/vim-codefmt"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-cpp-modern"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-cpp-modern",
    url = "https://github.com/bfrg/vim-cpp-modern"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gas"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-gas",
    url = "https://github.com/shirk/vim-gas"
  },
  ["vim-gitgutter"] = {
    commands = { "GitGutterToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-grammarous"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-grammarous",
    url = "https://github.com/rhysd/vim-grammarous"
  },
  ["vim-hindent"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-hindent",
    url = "https://github.com/alx741/vim-hindent"
  },
  ["vim-http-client"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-http-client",
    url = "https://github.com/aquach/vim-http-client"
  },
  ["vim-indent-guides"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-indent-guides",
    url = "https://github.com/nathanaelkane/vim-indent-guides"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-javascript",
    url = "https://github.com/pangloss/vim-javascript"
  },
  ["vim-jsx-improve"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-jsx-improve",
    url = "https://github.com/neoclide/vim-jsx-improve"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty",
    url = "https://github.com/maxmellon/vim-jsx-pretty"
  },
  ["vim-latexfmt"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-latexfmt",
    url = "https://github.com/anglypascal/vim-latexfmt"
  },
  ["vim-literate"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-literate",
    url = "https://github.com/khardix/vim-literate"
  },
  ["vim-maktaba"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-maktaba",
    url = "https://github.com/google/vim-maktaba"
  },
  ["vim-mustache-handlebars"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-mustache-handlebars",
    url = "https://github.com/mustache/vim-mustache-handlebars"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  vimtex = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["yats.vim"] = {
    loaded = true,
    path = "/home/ahsan/.local/share/nvim/site/pack/packer/start/yats.vim",
    url = "https://github.com/HerringtonDarkholme/yats.vim"
  }
}

time([[Defining packer_plugins]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'ALEEnable', function(cmdargs)
          require('packer.load')({'ale'}, { cmd = 'ALEEnable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'ale'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ALEEnable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'GitGutterToggle', function(cmdargs)
          require('packer.load')({'vim-gitgutter'}, { cmd = 'GitGutterToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'vim-gitgutter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('GitGutterToggle ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-grammarous', 'vim-mustache-handlebars'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-mustache-handlebars'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType mustache ++once lua require("packer.load")({'vim-mustache-handlebars'}, { ft = "mustache" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'indentpython.vim', 'ale'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'ale'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'coc.nvim'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'coc.nvim'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'coc.nvim'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType ocaml ++once lua require("packer.load")({'coc.nvim'}, { ft = "ocaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'coc.nvim'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType haskell ++once lua require("packer.load")({'ale'}, { ft = "haskell" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'coc.nvim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'coc.nvim', 'ale'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'coc.nvim', 'ale'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vim-grammarous'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType text ++once lua require("packer.load")({'vim-grammarous'}, { ft = "text" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-mustache-handlebars/ftdetect/handlebars.vim]], true)
vim.cmd [[source /home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-mustache-handlebars/ftdetect/handlebars.vim]]
time([[Sourcing ftdetect script at: /home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-mustache-handlebars/ftdetect/handlebars.vim]], false)
time([[Sourcing ftdetect script at: /home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-mustache-handlebars/ftdetect/mustache.vim]], true)
vim.cmd [[source /home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-mustache-handlebars/ftdetect/mustache.vim]]
time([[Sourcing ftdetect script at: /home/ahsan/.local/share/nvim/site/pack/packer/opt/vim-mustache-handlebars/ftdetect/mustache.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

-- PLUGINS -----------------------

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python3_host_prog = '/home/ahsan/.venv/bin/python'

require("plugins").setup()
vim.g.polyglot_disabled = { 'latex' }

require('lualine').setup()
----------------------------------

-- SETTINGS  ---------------------
require("settings")
----------------------------------

-- LANG SETTINGS -----------------
require("lang_settings")
----------------------------------

-- KEY-BINDINGS ------------------
require("keybinds")
----------------------------------

-- CoC Setup ---------------------
require("coc")
----------------------------------

-- LSP Setup ---------------------
require("metals_config")
----------------------------------

-- require('colorizer').setup()

vim.cmd.color('bestblack')

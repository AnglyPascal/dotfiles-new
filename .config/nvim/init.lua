-- Disable netrw early
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.polyglot_disabled = { 'latex' }

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Setup plugins
require("plugins")

-- Set colorscheme
vim.cmd.colorscheme('bestblack')

-- Load project-local config if it exists
local project_local_config = vim.fn.getcwd() .. "/.nvim/init.lua"
if vim.fn.filereadable(project_local_config) == 1 then
  dofile(project_local_config)
end

vim.o.exrc = true   -- allow project-local config files (.nvim.lua, .exrc)
vim.o.secure = true -- disable unsafe commands in these files

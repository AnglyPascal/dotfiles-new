-- Filetype detection (modern approach)
vim.filetype.add({
  extension = {
    conf = "conf",
    s = "gas",
    cls = "tex",
    todo = "todo",
  },
  pattern = {
    [".*config%.py"] = "python",
  },
})

-- Disable netrw early
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local function find_python()
  -- Prefer the active virtualenv / conda env
  local prefix = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX
  if prefix then
    local p = prefix .. "/bin/python3"
    if vim.fn.executable(p) == 1 then return p end
  end
  -- Fall back to whatever python3 is on PATH
  return vim.fn.exepath("python3")
end
vim.g.python3_host_prog = find_python()

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

-- Project-local config (.nvim/init.lua)
-- Each path is sourced at most once per session even if you cd away and back.
local _sourced = {}
local function load_project_config(dir)
  local path = dir .. "/.nvim/init.lua"
  if _sourced[path] or vim.fn.filereadable(path) == 0 then return end
  _sourced[path] = true
  dofile(path)
  vim.notify("[local] loaded " .. path, vim.log.levels.INFO)
end

load_project_config(vim.fn.getcwd())

vim.api.nvim_create_autocmd("DirChanged", {
  callback = function(ev) load_project_config(ev.file) end,
  desc = "Load .nvim/init.lua when entering a project directory",
})

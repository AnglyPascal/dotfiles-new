# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration (dotfiles) using Lua, organized as a module tree under `lua/`. The config lives in a dotfiles repo at `~/.config/nvim` (symlinked). Primary use: C/C++, Rust, Python, with occasional Lua, Bash/Zsh, Markdown, and LaTeX.

**Stack:** lazy.nvim (plugin manager), native LSP, nvim-cmp (completion), Telescope (fuzzy finder), Gitsigns, Treesitter, Vimtex.

## Reload / Test Changes

There is no build step. Changes are picked up by restarting Neovim or, for most Lua changes:
```
:source %          " reload current file
:Lazy reload       " reload a specific plugin
:LspRestart        " restart language servers after lsp/ changes
:checkhealth       " verify setup is healthy
```

Plugin installs/updates:
```
:Lazy sync         " install missing, update all, clean removed
:Lazy update       " update all plugins
:Mason             " manage LSP servers / formatters / linters
```

## Architecture

### Initialization flow (`init.lua`)
1. Filetype overrides for `.conf`, `.s`, `.cls`, `.todo`
2. Disable netrw; set Python3 host
3. Bootstrap `lazy.nvim` (auto-clones to `~/.local/share/nvim/lazy/lazy.nvim`)
4. Load `core.{options,keymaps,autocmds}`
5. Load `plugins` (lazy.nvim setup with all plugin groups)
6. Set colorscheme (`bestblack`/`bestwhite` — custom Xcode-inspired themes in `colors/`)
7. Source `.nvim/init.lua` if present in the project root (project-local config)

### Plugin organization (`lua/plugins/`)
Each file returns a table of lazy.nvim plugin specs:
- `editor.lua` — nvim-tree, Telescope, autopairs, surround, aerial, spectre, colorizer
- `ui.lua` — lualine, nvim-web-devicons, vim-polyglot
- `lsp.lua` — nvim-lspconfig, mason, mason-lspconfig, none-ls
- `completion.lua` — nvim-cmp + sources (lsp, buffer, path, cmdline, vsnip)
- `git.lua` — vim-fugitive, gitsigns
- `treesitter.lua` — nvim-treesitter, markview
- `latex.lua` — vimtex, ultisnips, vim-latexfmt
- `languages.lua` — language-specific syntax/formatting plugins
- `molten.lua` — Jupyter notebook support (molten-nvim, image.nvim)

### LSP setup (`lua/config/lsp/`)
- `init.lua` — `on_attach` callback (keymaps: `gd`, `gD`, `gK`, `gi`, `gr`, `<leader>rn`, `<leader>ca`, `<leader>f`), diagnostics config, capabilities with nvim-cmp
- `servers.lua` — per-server settings tables; servers are declared here and installed/managed via Mason

Active servers: `clangd`, `rust_analyzer`, `pyright`, `lua_ls`, `bashls`, `ts_ls`, `gopls`, `jsonls`, `yamlls`, `cssls`, `cmake`, `protols`.

To add a new server: add its config to `servers.lua` and ensure Mason installs it.

### Key conventions
- **Leader key:** `;`
- **Escape in insert:** `jk` / `kj`
- **Window movement:** `H/J/K/L` (splits), `<C-j>/<C-k>` (tabs)
- Plugin keymaps live in their plugin spec's `keys = {}` table, not in `core/keymaps.lua`
- `core/autocmds.lua` handles filetype-specific overrides (indent widths, spelling, formatters)
- Disabled language modules (Scala, Haskell, Java) are in `lua/languages/` but not loaded

## Migration Context

The user wants to modernize this config. Key areas identified for migration:

| Current | Modern Replacement | Reason |
|---|---|---|
| `nvim-cmp` + `vim-vsnip` | `blink.cmp` + `LuaSnip` | blink.cmp is faster, actively developed; LuaSnip is the standard snippet engine |
| `none-ls.nvim` | `conform.nvim` + `nvim-lint` | none-ls is unmaintained; conform for formatting, nvim-lint for linting |
| `vim-polyglot` | Remove (Treesitter covers it) | Treesitter handles syntax for all primary languages |
| `vim-vsnip` snippets | `LuaSnip` with `luasnip-snippets` or `friendly-snippets` | LuaSnip is the community standard |
| `SirVer/ultisnips` (LaTeX) | `LuaSnip` with vimtex integration | Consolidate to one snippet engine |
| `vim-commentary` | `mini.comment` or built-in `gc` (Neovim 0.10+) | Built-in comment operator since Neovim 0.10 |
| `vim-surround` | `mini.surround` or `nvim-surround` | Lua replacements with better dot-repeat |

**Do not replace:** lazy.nvim, Telescope, Gitsigns, Treesitter, nvim-lspconfig/Mason, vimtex, nvim-tree, lualine.

**LaTeX note:** vimtex uses `lualatex` and Zathura as the viewer. UltiSnips is used for LaTeX-specific snippets; migrating to LuaSnip requires setting `g:vimtex_snippets_engine = 'luasnip'`.

**Formatter specifics:**
- Python: `yapf` (currently via none-ls pyright + yapf)
- C/C++: `clang-format` (via `vim-clang-format` plugin)
- Lua: `stylua`
- Rust: `rustfmt` (via rust_analyzer)

When migrating formatters to conform.nvim, preserve these per-filetype formatters in `conform.nvim`'s `formatters_by_ft` table.

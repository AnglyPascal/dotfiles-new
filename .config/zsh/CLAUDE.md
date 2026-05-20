# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modular zsh configuration built on top of Oh My Zsh with Starship prompt. The entry point is `~/.zshrc` (symlinked from this repo at `.zshrc`). All modules are sourced explicitly in order — there is no auto-loading.

## Module structure

| File | Purpose |
|---|---|
| `.zshrc` | Entry point: OMZ setup, plugin list, keybindings, history, PATH |
| `core.zsh` | Core aliases, modern CLI tool replacements (eza/bat/rg/dust/duf), theme toggling |
| `dev.zsh` | Git aliases, C++/CMake build helpers (`cpp_build`, `cpp_clean`, `cpp_run`, `com`), `gcheat` |
| `media.zsh` | mpv/feh/zathura wrappers, video utilities (`mpvs`, `combine_videos`, `compress_video`) |
| `utils.zsh` | Find/search helpers (`ff`, `fe`, `fv`, `fp`, `fs`, `fmod`, `flarge`), archive extraction (`ex`, `uz`), `sea` (LUKS mount), `tk`/`cq` (yt-dlp helpers) |
| `autocomplete.zsh` | Per-command zstyle completion rules (file type filtering for nvim, mpv, feh, gcc, etc.) |
| `catppuccin_mocha.zsh` | `ZSH_HIGHLIGHT_STYLES` for zsh-syntax-highlighting |
| `lscolors.sh` | `LS_COLORS` definitions |

## Key design patterns

**Tool fallbacks**: `core.zsh` and `utils.zsh` check `command -v` for modern tools (eza, bat, rg, fd, dust, duf) and fall back to standard equivalents. New aliases/functions should follow this pattern.

**Background processes**: Media wrappers (`mpv`, `feh`, `z`, `fm`) use `&!` (disown) so they don't block the shell.

**Build type shorthand**: `cpp_build`/`cpp_clean`/`cpp_run` use `d`=Debug → `build_dev/`, `r`=Release → `build/`. Debug and Release use different directories.

**OMZ plugins requiring manual install** (noted in `.zshrc` comments):
- `zsh-syntax-highlighting` — clone into `$ZSH_CUSTOM/plugins/`
- `zsh-vi-mode` — clone into `$ZSH_CUSTOM/plugins/`
- `autoswitch_virtualenv` — clone into `$ZSH_CUSTOM/plugins/`

## Testing changes

Source the modified file directly to test without restarting the shell:
```sh
source ~/.config/zsh/<module>.zsh
```

To reload the full config:
```sh
source ~/.zshrc
```

To check for syntax errors before sourcing:
```sh
zsh -n ~/.config/zsh/<module>.zsh
```

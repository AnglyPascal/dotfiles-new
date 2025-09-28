# =============================================================================
# ~/.zshrc - Modular config with OMZ + Starship (Simple Source Approach)
# =============================================================================

export ZSH="/home/ahsan/.oh-my-zsh"
source "$HOME/.config/zsh/catppuccin_mocha.zsh"

DISABLE_MAGIC_FUNCTIONS=true # disable OMZ magic functions
ZSH_THEME=""

plugins=(
    git
    extract
    colored-man-pages
    command-not-found
    sudo
    zsh-syntax-highlighting
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    #   ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    zsh-vi-mode
    # git clone https://github.com/jeffreytse/zsh-vi-mode.git \
    #   ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

source "$HOME/.config/zsh/lscolors.sh"
source "$HOME/.config/zsh/core.zsh"
source "$HOME/.config/zsh/dev.zsh"
source "$HOME/.config/zsh/media.zsh"
source "$HOME/.config/zsh/utils.zsh"
source "$HOME/.config/zsh/autocomplete.zsh"

[[ -f "$HOME/git/oxford/misc/scripts/notes.zsh" ]] && source "$HOME/git/oxford/misc/scripts/notes.zsh"
[[ -f "$HOME/git/archive/socialsync/scripts/commands.zsh" ]] && source "$HOME/git/archive/socialsync/scripts/commands.zsh"

[[ -f "$HOME/.venv/bin/activate" ]] && source "$HOME/.venv/bin/activate"

ZVM_VI_INSERT_ESCAPE_BINDKEY=kj

bindkey -r '\e/'

bindkey -s ";l" 'ls^M'
bindkey -s ";f" 'fm;q^M'
bindkey -s ";n" 'nvim^M'
bindkey -s ";r" 'ranger^M'
bindkey -s ";/" 'grg '

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

setopt EXTENDED_GLOB
setopt NO_CASE_GLOB

bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

if zle -la history-substring-search-up; then
    bindkey '^P' history-substring-search-up
    bindkey '^N' history-substring-search-down
else
    bindkey '^P' up-line-or-history
    bindkey '^N' down-line-or-history
fi

if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else
    echo "⚠️  Starship not found - install with: curl -sS https://starship.rs/install.sh | sh"
fi

export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

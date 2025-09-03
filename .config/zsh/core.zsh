# =============================================================================
# ~/.config/zsh/core.zsh - Core aliases and modern tool integration
# =============================================================================

# Essential shortcuts
alias q='exit'
alias c='clear'
alias now='echo $(basename $(pwd))'

# Safe operations
alias rm='rm -v'
alias rr='rm -r'
alias cp="cp -i"

# Modern tool replacements with fallbacks
if command -v eza &> /dev/null; then
    alias ls='eza --group-directories-first --icons'
    alias ll='eza -la --group-directories-first --icons --git'
    alias la='eza -a --group-directories-first --icons'
    alias ld='eza -D'
    alias lt='eza --tree'
    alias lc='eza --group-directories-first --icons -I "*.class|*.out|*.o"'
else
    alias ls='ls -X --group-directories-first --color=auto'
    alias ll='ls -alF'
    alias la='ls -XA --group-directories-first --color=auto'
    alias ld='ls -d */'
    alias lc='ls --hide="*.class" --hide="*.out" --hide="*.o"'
fi

if command -v bat &> /dev/null; then
    alias cat='bat --paging=never'
    alias less='bat'
fi

if command -v dust &> /dev/null; then
    alias du='dust'
else
    alias du='du -h'
fi

if command -v duf &> /dev/null; then
    alias df='duf'
else
    alias df='df -h'
fi

if command -v rg &> /dev/null; then
    alias grep='rg'
    alias rgh='history | rg'
fi

# System info
alias free='free -m'

# Quick edit shortcuts  
alias vrc='nvim ~/.zshrc'
alias vzsh='nvim ~/.config/zsh/'
alias vi3='nvim ~/.config/i3/config'

# Theme switching
toggle_theme() {
    local alacritty_config="$HOME/.config/alacritty/alacritty.toml"
    if [[ -f "$alacritty_config" ]]; then
        if grep -Fq "light.yaml" "$alacritty_config"; then
            sed -i 's/light\.yaml/dark\.yaml/' "$alacritty_config"
            echo "→ Dark theme"
        else
            sed -i 's/dark\.yaml/light\.yaml/' "$alacritty_config" 
            echo "→ Light theme"
        fi
    fi
    
    local nvim_config="$HOME/.config/nvim/init.lua"
    if [[ -f "$nvim_config" ]]; then
        if grep -Fq "bestwhite" "$nvim_config"; then
            sed -i 's/bestwhite/bestblack/' "$nvim_config"
        else
            sed -i 's/bestblack/bestwhite/' "$nvim_config"
        fi
    fi
}

alias switch='toggle_theme'

# Environment setup
export CLASSPATH=".:$CLASSPATH:$HOME/git/oxford/lib:/usr/bin/latexmk"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig"
export SUDO_EDITOR="nvim"
export TMUX_CONF="$HOME/.config/tmux/tmux.conf"
export PATH="~/.npm-global/bin:$PATH"

# Custom tmux alias with your config
alias tmux="tmux -f $TMUX_CONF"

# Note: LS_COLORS loaded from your existing lscolors.sh by .zshrc

export ZSH="/home/ahsan/.oh-my-zsh"
source "$HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"

DISABLE_MAGIC_FUNCTIONS=true
plugins=(git extract)
source $ZSH/oh-my-zsh.sh

source "$HOME/.config/zsh/lscolors.sh"
source "$HOME/.config/zsh/zsh-vim-mode.plugin.zsh"

source "$HOME/.config/zsh/definitions.zsh"
source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/autocomplete.zsh"
source "$HOME/.config/zsh/net.zsh"
source "$HOME/.config/zsh/apps.zsh"
source "$HOME/.config/zsh/graphics.zsh"

source "$HOME/git/oxford/misc/scripts/notes.zsh"
source "$HOME/git/archive/socialsync/scripts/commands.zsh"

bindkey -v
bindkey jk vi-cmd-mode
bindkey kj vi-cmd-mode
bindkey -r '\e/'

bindkey -s ";l" 'ls^M'
bindkey -s ";f" 'fm;q^M'
bindkey -s ";n" 'nvim^M'
bindkey -s ";r" 'ranger^M'
bindkey -s ";/" 'grg '

eval "$(starship init zsh)"
source "$HOME/.config/zsh/classpaths.zsh"

source "$HOME/.venv/bin/activate"

export TMUX_CONF="$HOME/.config/tmux/tmux.conf"
alias tmux="tmux -f $TMUX_CONF"

export SUDO_EDITOR="nvim"
export PATH=~/.npm-global/bin:$PATH

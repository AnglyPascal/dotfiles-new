export ZSH="/home/ahsan/.oh-my-zsh"
source "$HOME/.config/zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"

DISABLE_MAGIC_FUNCTIONS=true
plugins=(git extract zsh-syntax-highlighting)
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
source "$HOME/git/socialsync/scripts/commands.zsh"

bindkey -v
bindkey jk vi-cmd-mode
bindkey kj vi-cmd-mode
bindkey -r '\e/'

bindkey -s "^L" 'ls^M'
bindkey -s "^F" 'fm;q^M'

eval "$(starship init zsh)"
source "$HOME/.config/zsh/classpaths.zsh"

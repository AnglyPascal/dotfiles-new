export ZSH="/home/ahsan/.oh-my-zsh"
DISABLE_MAGIC_FUNCTIONS=true
plugins=(git extract)
source $ZSH/oh-my-zsh.sh

source "/home/ahsan/.config/zsh/lscolors.sh"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

source "/home/ahsan/.config/zsh/zsh-vim-mode.plugin.zsh"
source "/home/ahsan/.config/zsh/dirs.zsh"
source "/home/ahsan/.config/zsh/net.zsh"
source "/home/ahsan/.config/zsh/apps.zsh"
source "/home/ahsan/.config/zsh/funcs.zsh"
source "/home/ahsan/git/socialsync/scripts/commands.zsh"

bindkey -v
bindkey jk vi-cmd-mode
bindkey kj vi-cmd-mode
bindkey -r '\e/'

eval "$(starship init zsh)"
export CLASSPATH=.:$CLASSPATH:/home/ahsan/git/oxford/lib:/usr/bin/latexmk

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH


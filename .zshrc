export ZSH="/home/ahsan/.oh-my-zsh"
DISABLE_MAGIC_FUNCTIONS=true
plugins=(git extract)
source $ZSH/oh-my-zsh.sh

source "/home/ahsan/.config/zsh/lscolors.sh"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' file-sort modification

zstyle ':completion:*' matcher-list ''                      \
  'r:|?=** m:{a-z\-}={A-Z\_}'                               \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}'  \
  'r:|?=** m:{a-z\-}={A-Z\_}'

zstyle ':completion:*:*:nvim:*' file-patterns                                        \
  '^*.(synctex*|aux|log|ent|idx|ilg|ind|pdf|fls|class|out|fdb_latexmk|toc|gz|nav|snm|hi|o):source-files' \
  '*:all-files'
zstyle ':completion:*:*:lualatex:*' file-patterns                                   \
  '*.(tex|sty):source-files' '*:all-files'
zstyle ':completion:*:*:scalatest:*' file-patterns                                   \
  '*.scala:source-files' '*:all-files'
zstyle ':completion:*:*:z:*' file-patterns                                          \
  '*.(pdf|djvu|cbz|zip|rar|cbr|epub):source-files' '*:all-files'
zstyle ':completion:*:*:mcomix:*' file-patterns                                     \
  '*.(cbz|cbr):source-files' '*:all-files'
zstyle ':completion:*:*:mpv:*' file-patterns                                        \
  '*.(gif|mkv|mp4|flv|webm|mp3|flac|ogg):source-files' '*:all-files'
zstyle ':completion:*:*:feh:*' file-patterns                                        \
  '*.(jpg|jpeg|png|webp):source-files' '*:all-files'
zstyle ':completion:*:*:fig:*' file-patterns                                        \
  '*.svg:source-files' '*:all-files'

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
export PATH="$HOME/.jenv/bin:/home/ahsan/.local/share/gem/ruby/3.0.0/bin:$PATH"
eval "$(jenv init -)"
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# opam configuration
[[ ! -r /home/ahsan/.opam/opam-init/init.zsh ]] || source /home/ahsan/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH
OXFORD=/home/ahsan/git/oxford
export OXFORD

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/run/media/file1/Softwares/google-cloud-sdk/path.zsh.inc' ]; then . '/run/media/file1/Softwares/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/run/media/file1/Softwares/google-cloud-sdk/completion.zsh.inc' ]; then . '/run/media/file1/Softwares/google-cloud-sdk/completion.zsh.inc'; fi

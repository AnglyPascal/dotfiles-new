zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' file-sort modification

zstyle ':completion:*' matcher-list ''                      \
  'r:|?=** m:{a-z\-}={A-Z\_}'                               \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}'  \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# nvim
zstyle ':completion:*:*:nvim:*' file-patterns                                        \
  '^*.(synctex*|aux|log|ent|idx|ilg|ind|pdf|fls|class|out|fdb_latexmk|toc|gz|nav|snm|hi|o):source-files' \
  '*:all-files'

# lualatex
zstyle ':completion:*:*:lualatex:*' file-patterns                                   \
  '*.(tex|sty):source-files' '*:all-files'

# scala
zstyle ':completion:*:*:scalatest:*' file-patterns                                   \
  '*.scala:source-files' '*:all-files'

# documents
zstyle ':completion:*:*:z:*' file-patterns                                          \
  '*.(pdf|djvu|cbz|zip|rar|cbr|epub):source-files' '*:all-files'

# mcomix
zstyle ':completion:*:*:mcomix:*' file-patterns                                     \
  '*.(cbz|cbr):source-files' '*:all-files'

# mpv
zstyle ':completion:*:*:mpv:*' file-patterns                                        \
  '*.(gif|mkv|mp4|flv|webm|mp3|flac|ogg):source-files' '*:all-files'

# feh
zstyle ':completion:*:*:feh:*' file-patterns                                        \
  '*.(jpg|jpeg|png|webp):source-files' '*:all-files'

# ???
zstyle ':completion:*:*:fig:*' file-patterns                                        \
  '*.svg:source-files' '*:all-files'

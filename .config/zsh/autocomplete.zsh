zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' file-sort modification

zstyle ':completion:*' matcher-list ''                      \
  'r:|?=** m:{a-z\-}={A-Z\_}'                               \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}'  \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# nvim - exclude build artifacts, temp files, binaries but include all text/code files
zstyle ':completion:*:*:nvim:*' file-patterns \
  '^*.(synctex*|aux|log|ent|idx|ilg|ind|pdf|fls|class|out|fdb_latexmk|toc|gz|nav|snm|hi|o|so|a|dylib|dll|exe|bin|obj|pyc|pyo|pyd|__pycache__|node_modules|.git|.svn|.hg|DS_Store|thumbs.db|desktop.ini|.tmp|.swp|.swo|~|.bak|.orig|.lock|.pid):source-files' \
  '*:all-files'

# lualatex - comprehensive LaTeX ecosystem support
zstyle ':completion:*:*:lualatex:*' file-patterns \
  '*.(tex|sty|cls|dtx|ins|bib|bst|bbx|cbx|lbx|def|cfg|clo|fd|map|enc|tfm|vf|pk|gf|mf):source-files' \
  '*:all-files'

# pdflatex - same as lualatex
zstyle ':completion:*:*:pdflatex:*' file-patterns \
  '*.(tex|sty|cls|dtx|ins|bib|bst|bbx|cbx|lbx|def|cfg|clo|fd|map|enc|tfm|vf|pk|gf|mf):source-files' \
  '*:all-files'

# xelatex - same as lualatex  
zstyle ':completion:*:*:xelatex:*' file-patterns \
  '*.(tex|sty|cls|dtx|ins|bib|bst|bbx|cbx|lbx|def|cfg|clo|fd|map|enc|tfm|vf|pk|gf|mf):source-files' \
  '*:all-files'

# z/zathura - comprehensive document viewer support
zstyle ':completion:*:*:z:*' file-patterns \
  '*.(pdf|djvu|djv|epub|mobi|azw|azw3|fb2|cbz|cbr|cb7|cbt|zip|rar|7z|tar|tar.gz|tar.bz2|tar.xz|ps|eps|xps|oxps|dvi):source-files' \
  '*:all-files'

zstyle ':completion:*:*:zathura:*' file-patterns \
  '*.(pdf|djvu|djv|epub|ps|eps|dvi|xps|oxps|cbz|cbr):source-files' \
  '*:all-files'

# mcomix - comic/archive reader
zstyle ':completion:*:*:mcomix:*' file-patterns \
  '*.(cbz|cbr|cb7|cbt|zip|rar|7z|tar|ace|lha|lzh|arj|zoo):source-files' \
  '*:all-files'

# mpv - comprehensive media player support
zstyle ':completion:*:*:mpv:*' file-patterns \
  '*.(mp4|mkv|avi|mov|wmv|flv|webm|m4v|3gp|3g2|ogv|ogm|rmvb|asf|vob|ts|m2ts|mts|divx|xvid|gif|mp3|flac|ogg|opus|aac|m4a|wma|wav|ape|wv|tta|aiff|au|ra|mka|mpc|ac3|dts|amr|gsm|spx|tak|weba|caf|sd2|iff|voc|w64|mat|pvf|xi|snd|aff|8svx|smp|txw|amb|cdr|dvf|sph|msv|nist|cvsd|cvs|vms|paf|pvf):source-files' \
  '*:all-files'

# feh - comprehensive image viewer support
zstyle ':completion:*:*:feh:*' file-patterns \
  '*.(jpg|jpeg|png|gif|bmp|tiff|tif|webp|svg|ico|xcf|psd|raw|cr2|cr3|nef|orf|arw|dng|rw2|pef|srw|x3f|erf|raf|3fr|fff|iiq|k25|kdc|mef|mos|mrw|nrw|ptx|r3d|rwl|rwz|sr2|srf|srw):source-files' \
  '*:all-files'

# gimp - image editing formats
zstyle ':completion:*:*:gimp:*' file-patterns \
  '*.(jpg|jpeg|png|gif|bmp|tiff|tif|webp|svg|ico|xcf|psd|raw|cr2|cr3|nef|orf|arw|dng|rw2|pef|srw|x3f|erf|raf|3fr|fff|iiq|k25|kdc|mef|mos|mrw|nrw|ptx|r3d|rwl|rwz|sr2|srf|srw|ora|exr|hdr|pfm|rgbe|xyze):source-files' \
  '*:all-files'

# inkscape/fig - vector graphics
zstyle ':completion:*:*:fig:*' file-patterns \
  '*.(svg|svgz|eps|pdf|ps|ai|emf|wmf|fig|dxf|sk|sk1|cgm|odg):source-files' \
  '*:all-files'

zstyle ':completion:*:*:inkscape:*' file-patterns \
  '*.(svg|svgz|eps|pdf|ps|ai|emf|wmf|fig|dxf|sk|sk1|cgm|odg):source-files' \
  '*:all-files'

# LibreOffice applications
zstyle ':completion:*:*:libreoffice:*' file-patterns \
  '*.(odt|ods|odp|odg|odf|odb|doc|docx|xls|xlsx|ppt|pptx|rtf|csv|dbf|pdf):source-files' \
  '*:all-files'

# Archive utilities
zstyle ':completion:*:*:unzip:*' file-patterns \
  '*.(zip|jar|war|ear|aar|apk|pk3|pk4|love):source-files' \
  '*:all-files'

zstyle ':completion:*:*:unrar:*' file-patterns \
  '*.(rar|rev|r[0-9][0-9]):source-files' \
  '*:all-files'

zstyle ':completion:*:*:7z:*' file-patterns \
  '*.(7z|zip|rar|tar|gz|bz2|xz|lzma|cab|iso|dmg|hfs|wim|swm|esd):source-files' \
  '*:all-files'

# Development tools
zstyle ':completion:*:*:gcc:*' file-patterns \
  '*.(c|h|cpp|cxx|cc|c++|hpp|hxx|h++|hh|S|s|i|ii):source-files' \
  '*:all-files'

zstyle ':completion:*:*:g++:*' file-patterns \
  '*.(cpp|cxx|cc|c++|hpp|hxx|h++|hh|c|h|S|s|i|ii):source-files' \
  '*:all-files'

zstyle ':completion:*:*:clang:*' file-patterns \
  '*.(c|h|cpp|cxx|cc|c++|hpp|hxx|h++|hh|m|mm|S|s|i|ii):source-files' \
  '*:all-files'

zstyle ':completion:*:*:clang++:*' file-patterns \
  '*.(cpp|cxx|cc|c++|hpp|hxx|h++|hh|c|h|m|mm|S|s|i|ii):source-files' \
  '*:all-files'

zstyle ':completion:*:*:python:*' file-patterns \
  '*.(py|pyw|pyx|pxd|pxi|py3|pyi|ipynb):source-files' \
  '*:all-files'

zstyle ':completion:*:*:python3:*' file-patterns \
  '*.(py|pyw|pyx|pxd|pxi|py3|pyi|ipynb):source-files' \
  '*:all-files'

zstyle ':completion:*:*:node:*' file-patterns \
  '*.(js|mjs|cjs|json|ts|tsx|jsx|coffee|litcoffee):source-files' \
  '*:all-files'

zstyle ':completion:*:*:npm:*' file-patterns \
  '*.json:source-files' \
  '*:all-files'

# Web browsers
zstyle ':completion:*:*:brave:*' file-patterns \
  '*.(html|htm|xhtml|mhtml|svg|pdf|xml):source-files' \
  '*:all-files'

zstyle ':completion:*:*:qutebrowser:*' file-patterns \
  '*.(html|htm|xhtml|mhtml|svg|pdf|xml):source-files' \
  '*:all-files'

# Text editors
zstyle ':completion:*:*:code:*' file-patterns \
  '^*.(synctex*|aux|log|ent|idx|ilg|ind|pdf|fls|class|out|fdb_latexmk|toc|gz|nav|snm|hi|o|so|a|dylib|dll|exe|bin|obj|pyc|pyo|pyd|DS_Store|thumbs.db|node_modules|.git):source-files' \
  '*:all-files'

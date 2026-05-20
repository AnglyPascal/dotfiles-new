zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' file-sort modification

zstyle ':completion:*' matcher-list ''                      \
  'r:|?=** m:{a-z\-}={A-Z\_}'                               \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}'  \
  'r:|?=** m:{a-z\-}={A-Z\_}'

# Text editors — exclude build artifacts and generated files
zstyle ':completion:*:*:nvim:*' file-patterns \
    '^*.(synctex*|aux|log|ent|idx|ilg|ind|pdf|fls|class|out|fdb_latexmk|toc|gz|nav|snm|hi|o|so|a|dylib|dll|exe|bin|obj|pyc|pyo|pyd|__pycache__|node_modules|.git|.svn|.hg|DS_Store|thumbs.db|desktop.ini|.tmp|.swp|.swo|~|.bak|.orig|.lock|.pid):source-files' \
    '*:all-files'
zstyle ':completion:*:*:code:*' file-patterns \
    '^*.(synctex*|aux|log|ent|idx|ilg|ind|pdf|fls|class|out|fdb_latexmk|toc|gz|nav|snm|hi|o|so|a|dylib|dll|exe|bin|obj|pyc|pyo|pyd|DS_Store|thumbs.db|node_modules|.git):source-files' \
    '*:all-files'

# LaTeX — all three variants use identical patterns
_ac_tex='*.(tex|sty|cls|dtx|ins|bib|bst|bbx|cbx|lbx|def|cfg|clo|fd|map|enc|tfm|vf|pk|gf|mf):source-files'
for _ac_cmd in lualatex pdflatex xelatex; do
    zstyle ":completion:*:*:${_ac_cmd}:*" file-patterns "$_ac_tex" '*:all-files'
done

# Document viewers
zstyle ':completion:*:*:z:*' file-patterns \
    '*.(pdf|djvu|djv|epub|mobi|azw|azw3|fb2|cbz|cbr|cb7|cbt|zip|rar|7z|tar|tar.gz|tar.bz2|tar.xz|ps|eps|xps|oxps|dvi):source-files' \
    '*:all-files'
zstyle ':completion:*:*:zathura:*' file-patterns \
    '*.(pdf|djvu|djv|epub|ps|eps|dvi|xps|oxps|cbz|cbr):source-files' \
    '*:all-files'
zstyle ':completion:*:*:mcomix:*' file-patterns \
    '*.(cbz|cbr|cb7|cbt|zip|rar|7z|tar|ace|lha|lzh|arj|zoo):source-files' \
    '*:all-files'

# Media
_ac_video='mp4|mkv|avi|mov|wmv|flv|webm|m4v|3gp|3g2|ogv|vob|ts|m2ts|gif'
_ac_audio='mp3|flac|ogg|opus|aac|m4a|wma|wav|mka|ac3|dts'
zstyle ':completion:*:*:mpv:*' file-patterns \
    '*(/)':directories \
    "*.(${_ac_video}|${_ac_audio}):source-files" \
    '*:all-files'

_ac_images='jpg|jpeg|png|gif|bmp|tiff|tif|webp|svg|ico|xcf|psd|raw|cr2|cr3|nef|orf|arw|dng|rw2|pef|srw|x3f|erf|raf|3fr|fff|iiq|k25|kdc|mef|mos|mrw|nrw|ptx|r3d|rwl|rwz|sr2|srf'
zstyle ':completion:*:*:feh:*'  file-patterns "*.(${_ac_images}):source-files" '*:all-files'
zstyle ':completion:*:*:gimp:*' file-patterns "*.(${_ac_images}|ora|exr|hdr|pfm|rgbe|xyze):source-files" '*:all-files'

# Vector graphics — fig and inkscape use identical patterns
_ac_vector='*.(svg|svgz|eps|pdf|ps|ai|emf|wmf|fig|dxf|sk|sk1|cgm|odg):source-files'
for _ac_cmd in fig inkscape; do
    zstyle ":completion:*:*:${_ac_cmd}:*" file-patterns "$_ac_vector" '*:all-files'
done

# Archives
zstyle ':completion:*:*:unzip:*' file-patterns '*.(zip|jar|war|ear|aar|apk|pk3|pk4|love):source-files' '*:all-files'
zstyle ':completion:*:*:unrar:*' file-patterns '*.(rar|rev|r[0-9][0-9]):source-files' '*:all-files'
zstyle ':completion:*:*:7z:*'    file-patterns '*.(7z|zip|rar|tar|gz|bz2|xz|lzma|cab|iso|dmg|hfs|wim|swm|esd):source-files' '*:all-files'

# C/C++ compilers — clang variants add Objective-C (m|mm)
_ac_c_src='*.(c|h|cpp|cxx|cc|c++|hpp|hxx|h++|hh|S|s|i|ii):source-files'
_ac_objc_src='*.(c|h|cpp|cxx|cc|c++|hpp|hxx|h++|hh|m|mm|S|s|i|ii):source-files'
for _ac_cmd in gcc g++;       do zstyle ":completion:*:*:${_ac_cmd}:*" file-patterns "$_ac_c_src"    '*:all-files'; done
for _ac_cmd in clang clang++; do zstyle ":completion:*:*:${_ac_cmd}:*" file-patterns "$_ac_objc_src" '*:all-files'; done

# Python
_ac_py='*.(py|pyw|pyx|pxd|pxi|py3|pyi|ipynb):source-files'
for _ac_cmd in python python3; do
    zstyle ":completion:*:*:${_ac_cmd}:*" file-patterns "$_ac_py" '*:all-files'
done

# JavaScript
zstyle ':completion:*:*:node:*' file-patterns '*.(js|mjs|cjs|json|ts|tsx|jsx|coffee|litcoffee):source-files' '*:all-files'
zstyle ':completion:*:*:npm:*'  file-patterns '*.json:source-files' '*:all-files'

# Web browsers
_ac_html='*.(html|htm|xhtml|mhtml|svg|pdf|xml):source-files'
for _ac_cmd in brave qutebrowser; do
    zstyle ":completion:*:*:${_ac_cmd}:*" file-patterns "$_ac_html" '*:all-files'
done

# Office
zstyle ':completion:*:*:libreoffice:*' file-patterns \
    '*.(odt|ods|odp|odg|odf|odb|doc|docx|xls|xlsx|ppt|pptx|rtf|csv|dbf|pdf):source-files' \
    '*:all-files'

unset _ac_tex _ac_cmd _ac_video _ac_audio _ac_images _ac_vector _ac_c_src _ac_objc_src _ac_py _ac_html

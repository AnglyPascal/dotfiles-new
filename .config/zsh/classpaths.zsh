export CLASSPATH=.:$CLASSPATH:$HOME/git/oxford/lib:/usr/bin/latexmk

export PATH="$HOME/.jenv/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"

eval "$(jenv init -)"

# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH

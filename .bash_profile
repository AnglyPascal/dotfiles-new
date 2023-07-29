#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
PATH=$PATH:above/path/to/gems
export PATH="$HOME/.jenv/bin:$PATH"

# >>> coursier install directory >>>
export PATH="$PATH:/home/ahsan/.local/share/coursier/bin"
# <<< coursier install directory <<<
. "$HOME/.cargo/env"

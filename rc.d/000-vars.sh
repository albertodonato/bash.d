# -*- mode: sh -*-
#
# Environment variables exports
#

# Keep the original path, so it can be reapplied on reload
[ -z "$_PATH" ] && _PATH="$PATH"
PATH="$HOME/bin:$SYSTEM_DIR/bin:$SYSTEM_BASH_DIR/bin:$_PATH"
PATH+=":$HOME/.local/bin:$HOME/node_modules/.bin"

export HISTFILESIZE=100000

export EDITOR="emacsclient -c -a vim"
export LESS="-R"

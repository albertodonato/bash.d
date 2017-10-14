# -*- mode: sh -*-
#
# Environment variables exports


# Keep the original path, so it can be reapplied on reload
[ -z "$_PATH" ] && _PATH="$PATH"
PATH="$HOME/bin:$SYSTEM_DIR/bin:$SYSTEM_BASH_DIR/bin:$_PATH"
PATH+=":$HOME/.local/bin"

export GOPATH="$HOME/go"
PATH+=":$GOPATH/bin"

export HISTFILESIZE=100000

export EDITOR="emacsclient -c"
export ALTERNATE_EDITOR=""  # to start emacs server
export LESS="-R"

export EMAIL="alberto.donato@gmail.com"
export DEBEMAIL="$EMAIL"

# Environment variables exports


# Keep the original path, so it can be reapplied on reload
[ -z "$_PATH" ] && _PATH="$PATH"
PATH="$HOME/bin:$SYSTEM_DIR/bin:$SYSTEM_BASH_DIR/bin:$_PATH"
PATH+=":$HOME/.local/bin"
PATH+=":$HOME/.cargo/bin"
PATH+=":$HOME/npm/bin"
PATH+=":$HOME/venv/bin"

export GOPATH="$HOME/go"
PATH+=":$GOPATH/bin"

export HISTFILESIZE=100000

export LESS="-R"

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

export EDITOR="emacsclient -c"
export ALTERNATE_EDITOR=""  # to start emacs server
export EMACS_SOCKET_NAME
EMACS_SOCKET_NAME="/run/user/$(id -u)/emacs/server"

export LESS="-R"

export MOZ_ENABLE_WAYLAND=1

export DOCKER_BUILDKIT=1

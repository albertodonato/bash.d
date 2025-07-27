# Environment variables exports


# Keep the original path, so it can be reapplied on reload
[ -z "$_PATH" ] && _PATH="$PATH"
PATH="$SYSTEM_DIR/bin:$SYSTEM_BASH_DIR/bin:$_PATH"

export HISTFILESIZE=100000
export LESS="-R"

# Environment variables exports


# Keep the original path, so it can be reapplied on reload
[ -z "$_PATH" ] && _PATH="$PATH"
PATH="$SHELL_D/bin:$_PATH"

HISTFILESIZE=100000

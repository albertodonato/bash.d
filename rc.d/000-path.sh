# Path configuration


# Keep the original path, so it can be reapplied on reload
[ -z "$_path" ] && _path="$PATH"
PATH="${_shell_d}/bin:${_path}"

# -*- mode: sh -*-
#
# Entry point for bash configuration


SHELL_D="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"


_find_shell_files() {
    local dir="$1"
    
    shopt -s nullglob
    printf '%s\n' "$dir"/*.{sh,bash} | sort
    shopt -u nullglob
}


. "${SHELL_D}/_shrc"



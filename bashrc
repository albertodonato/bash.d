# -*- mode: sh -*-
# shellcheck disable=SC1090
#
# Entry point for bash configuration.


# where all config files related to this repo live
export BASH_D_CONF="$HOME/.config/bash.d"


_find_shell_files() {
    local dir="$1"

    shopt -s nullglob
    printf '%s\n' "$dir"/*.sh | sort
    shopt -u nullglob
}

_source_all_shell() {
    local dir="$1"

    local -a files
    mapfile -t files < <(_find_shell_files "$dir")
    local f
    for f in "${files[@]}"; do
        . "$f";
    done
}

_source_if_exists() {
    if [ -f "$1" ]; then
        . "$1"
    fi
}


shell_d="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
_source_all_shell "${shell_d}/lib"
_source_all_shell "${shell_d}/rc.d"

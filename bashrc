# -*- mode: sh -*-
# shellcheck disable=SC1090
#
# Entry point for bash configuration


SHELL_D="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"


_find_shell_files() {
    local dir="$1"

    shopt -s nullglob
    printf '%s\n' "$dir"/*.{sh,bash} | sort
    shopt -u nullglob
}

_source_all_for_shell() {
    local dir="$1"

    local -a files
    mapfile -t files < <(_find_shell_files "$dir")
    for f in "${files[@]}"; do
        . "$f";
    done
}


. "${SHELL_D}/_shrc"

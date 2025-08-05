# -*- mode: sh -*-
#
# Entry point for zsh configuration


SHELL_D="$(realpath "$(dirname "${(%):-%x}")")"
SHELL_D_SHELL="zsh"

_find_shell_files() {
    local dir="$1"

    setopt NULL_GLOB
    print -l "$dir"/*.{sh,zsh} | sort
    unsetopt NULL_GLOB
}

_source_all_for_shell() {
    local dir="$1"

    local -a files
    files=("${(@f)$(_find_shell_files "$dir")}")
    local f
    for f in "${files[@]}"; do
        . "$f"
    done
}


. "${SHELL_D}/_shrc"

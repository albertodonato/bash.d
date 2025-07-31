# -*- mode: sh -*-
# shellcheck disable=SC1090
#
# Entry point for bash configuration


_shell() {
    if [ "$BASH_VERSION" ]; then
        echo "bash"
    elif [ "$ZSH_VERSION" ]; then
        echo "zsh"
    fi
}

source_if_exists() {
    if [ -f "$1" ]; then
        . "$1"
    fi
}

source_all_for_shell() {
    local dir="$1"
    
    # get sorted entries
    local -a files
    shopt -s nullglob
    mapfile -t files < <(printf '%s\n' "$dir"/*.{sh,"$(_shell)"} | sort)
    shopt -u nullglob
    for f in "${files[@]}"; do
        . "$f";
    done
}

case $(_shell) in
    bash)
        SHELL_D="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
        ;;
esac


source_all_for_shell "${SHELL_D}/lib"
source_all_for_shell "${SHELL_D}/rc.d"

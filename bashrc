# -*- mode: sh -*-
# shellcheck disable=SC1090
#
# Entry point for bash configuration


SYSTEM_BASH_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

source_if_exists() {
    if [ -f "$1" ]; then
        . "$1"
    fi
}

source_many() {
    local f
    for f in "$@"; do
        . "$f"
    done
}

source_many "$SYSTEM_BASH_DIR"/rc.d/*.sh

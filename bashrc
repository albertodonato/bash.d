# -*- mode: sh -*-
#
# Entry point for bash configuration
#

SYSTEM_DIR=$HOME/system
SYSTEM_BASH_DIR=$SYSTEM_DIR/bash.d
# Export for scripts
export SYSTEM_SH_LIB_DIR=$SYSTEM_BASH_DIR/lib

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

source_many $SYSTEM_BASH_DIR/rc.d/*.sh

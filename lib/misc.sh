# -*- mode: sh -*-

#
# Print boolean value of the exit code of the command passed as argument.
#
# Usage: bool [command args...]
#
bool() {
    "$@" && echo "true" || echo "false"
}

#
# Source a system file.
# If no filename is given, list the available names.
#
# Usage: s [<filename>, ...]
#
s() {
    local sourcedir=$SYSTEM_DIR/source
    if [ $# -eq 0 ]; then
        ls -1 $sourcedir;
        return
    fi

    local file
    for file in "$@"; do
        . "$sourcedir/$file"
    done
}

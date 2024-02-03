# Helper to source global definition files.

# Source a system file.  If no filename is given, list the available names.
s() {
    local sourcedir="$SYSTEM_DIR/source"
    if [ $# -eq 0 ]; then
        ls -1 "$sourcedir"
        return
    fi

    local file
    for file in "$@"; do
        # shellcheck disable=SC1090
        . "$sourcedir/$file"
    done
}

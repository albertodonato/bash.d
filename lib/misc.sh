# Miscellaneous shell-related functions.


# Print boolean value of the exit code of the command passed as argument.
bool() {
    "$@" && echo "true" || echo "false"
}

# Return whether a string is present in a list of strings.
contains_string() {
    local match="$1"
    local strings="$2"

    local s
    for s in $strings; do
        if [ "$s" == "$match" ]; then
            return 0
        fi
    done
    return 1
}

# Return whether the shell is interactive.
is_interactive() {
    [[ $- == *i* ]]
}

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

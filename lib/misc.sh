# -*- mode: sh -*-
#
# Miscellaneous shell-related functions.
#

#
# Print boolean value of the exit code of the command passed as argument.
#
# Usage: bool [command args...]
#
bool() {
    "$@" && echo "true" || echo "false"
}


#
# Split directories in a PATH-like variable
#
# Usage: split_path_dirs [string]
#
split_path_dirs() {
    echo "$1" | sed 's/:/\n/g'
}


#
# Return whether a string is present in a list of strings
#
# Usage: contains_string [a-string] [strings...]
#
contains_string() {
    local match="$1"
    local s
    for s in $2; do
        if [ "$s" == "$match" ]; then
            return 0
        fi
    done
    return 1
}


#
# Return whether the shell is interactive.
#
# Usage: is_interactive
#
is_interactive() {
    [[ $- == *i* ]]
}


#
# Source a system file.
# If no filename is given, list the available names.
#
# Usage: s [<filename>, ...]
#
s() {
    local sourcedir="$SYSTEM_DIR/source"
    if [ $# -eq 0 ]; then
        ls -1 $sourcedir;
        return
    fi

    local file
    for file in "$@"; do
        . "$sourcedir/$file"
    done
}

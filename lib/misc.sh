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
# Return whether the shell is interactive.
#
# Usage: is_interactive
#
is_interactive() {
    echo $- | grep -q i
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

#
# Autocomplete helper for the s() command.
#
if is_interactive; then
    _s() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local sources="$(ls -1 $SYSTEM_DIR/source)"
        COMPREPLY=( $(compgen -W "$sources" -- "$cur") )
    }

    complete -F _s s
fi

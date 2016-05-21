# -*- mode: sh -*-
#
# Utility functions for development.
# 

#
# Delete files ending with a tilde in specified tree (by default the current
# directory).
#
# Usage: deltilde [path]
# 
deltilde() {
    find "$@" -name \*~ -exec rm {} \;
}

#
# Delete .pyc files in specified tree (by default the current directory).
#
# Usage; delpyc [path]
# 
delpyc() {
    find "$@" -name \*.pyc -exec rm {} \;
}

#
# Activate a python virtualenv. List available ones if no name is specified.
#
# Usage: ve [name]
#
ve() {
    local name="$1"
    local dir="$HOME/virtualenv"
    local activate="$dir/$name/bin/activate"

    if [ -z "$name" ]; then
        echo "Available virtualenv:" 
        ls -1 "$dir" | sed 's/^/ /'
        return
    fi

    if [ ! -f "$activate" ]; then
        echo "Virtualenv not found" >&2
        return 2
    fi

    set_prompt_info virtualenv '0;49;31' "$name" ve
    VIRTUAL_ENV_DISABLE_PROMPT=1 . "$activate"
}

#
# Create a virtualenv with the specified name
#
# Usage mkve <name> [option...]
#
mkve() {
    if [ ! "$1" ]; then
        echo "Missing virtualenv name"
        return 1
    fi
    local dir="$HOME/virtualenv/$1"
    shift 1
 
    virtualenv "$dir" "$@"
}

#
# Create a script with the specified name.
#
# Usage: shebang <filename> [shebang]
#
shebang() {
    if [ ! "$1" ]; then
        echo "Missing filename"
        return 1
    fi

    local name="$1"
    shift 1
    local shebang="/bin/sh"
    [ $# -gt 0 ] && shebang="$@"

    echo -e "#!$shebang\n" > "$name"
    chmod +x "$name"
}

# shellcheck disable=SC1090,SC2039
#
# Utility functions for development.


# Delete files ending with a tilde in specified tree (by default the current
# directory).
deltilde() {
    find "$@" -name \*~ -exec rm {} \;
}

# Delete .pyc files in specified tree (by default the current directory).
delpyc() {
    find "$@" -type d -name __pycache__ -print0 | xargs --null rm -rf
    find "$@" -name \*.pyc -exec rm {} \;
}

# Activate a python virtualenv. List available ones if no name is specified.
ve() {
    local name="$1"

    local dir="$HOME/virtualenv"

    if [ -z "$name" ]; then
        echo "Available virtualenvs:"
        local venv venvs version
        venvs=$(find "$dir" -mindepth 1 -maxdepth 1 | sed 's,.*/,,' | sort)
        for venv in $venvs; do
            version=$(awk -F' = ' '$1 == "version" { print $2; }' "$dir/$venv/pyvenv.cfg")
            echo -e " $version\t$venv"
        done
        return
    fi

    local activate="$dir/$name/bin/activate"
    if [ ! -f "$activate" ]; then
        echo "Virtualenv not found" >&2
        return 2
    fi

    VIRTUAL_ENV_DISABLE_PROMPT=1 . "$activate"
}

# Create a virtualenv with the specified name and install packages.
mkve() {
    local name="$1"
    shift 1

    if [ -z "$name" ]; then
        echo "Missing virtualenv name"
        return 1
    fi

    local dir="$HOME/virtualenv/$name"
    python3 -m venv --clear "$dir"
    "$dir/bin/pip" install --upgrade pip "$@"
}

# Create a script with the specified name.
shebang() {
    local filename="$1"
    local shebang="/bin/bash -e"

    if [ -z "$filename" ]; then
        echo "Missing filename"
        return 1
    fi

    shift 1
    if [ $# -gt 0 ]; then
        shebang="$*"
        if [[ "$shebang" != /* ]]; then
            shebang="/usr/bin/env $shebang"
        fi
    fi

    local line="#!$shebang"

    touch "$filename"
    if [ "$(stat --printf="%s" "$filename")" -gt 0 ]; then
        sed -i '1 s,.*,'"$line", "$filename"
    else
        echo -e "$line\\n" > "$filename"
    fi
    chmod +x "$filename"
}

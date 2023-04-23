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

# Create a virtualenv in the specified dir, optionally installing packages.
mkvenv() {
    local path="$1"
    shift 1

    if [ -z "$path" ]; then
        echo "Missing virtualenv path" 2>&1
        return 1
    fi

    python3 -m venv --clear "$path"
    "$path/bin/pip" install --upgrade pip "$@"
}

# Create or update the virtualenv for globally-available Python applications.
#
# List of applications are taken from ~/.venv-global-requirements.txt
venv-make-global() {
    local requirements_file="$HOME/.venv-global-requirements.txt"
    if [ ! -e "$requirements_file" ]; then
        echo "Requirements file not found: $requirements_file" 2>&1
        return 1
    fi
    mkvenv "$HOME/venv" -r "$requirements_file" "$@"
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

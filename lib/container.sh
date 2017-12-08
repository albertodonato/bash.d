# -*- mode: sh -*-
# shellcheck disable=SC2039
#
# Linux containers utility functions.


# Return the type of container of the host.
container_type() {
    local type file
    for file in /run/container_type /run/systemd/container; do
        [ -f "$file" ] && type=$(cat "$file")
    done

    echo "$type"
}

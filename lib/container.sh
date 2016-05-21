# -*- mode: sh -*-
#
# Linux containers utility functions.
#

#
# Return the type of container of the host (or empty string if it's not a
# container).
#
# Usage: container_type
#
container_type() {
    local type file

    for file in /run/container_type /run/systemd/container; do
        [ -f $file ] && type=$(cat $file)
    done
    echo $type
}

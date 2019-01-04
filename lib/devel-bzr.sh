# -*- mode: sh -*-
# shellcheck disable=SC2039
#
# Utility functions for Bazaar.


# Return the name of the current pipe if different from the branch name.
bzr_pipe_if_different() {
    local path="$1"
    [ -n "$path" ] || path="$PWD"

    local dir pipe
    if _bzr_is_lw_checkout "$path"; then
        dir=$(basename "$path")
        pipe=$(_bzr_current_pipe "$path")
        [ "$dir" != "$pipe" ] && echo "$pipe"
    fi
}

_bzr_is_lw_checkout() {
    _bzr_info "$1" | grep -q "light checkout"
}

_bzr_current_pipe() {
    bzr pipes "$1" | awk '/^\*/ { print $2; }'
}

_bzr_info() {
    bzr info "$1" 2>/dev/null
}

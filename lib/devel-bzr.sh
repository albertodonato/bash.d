# -*- mode: sh -*-

#
# Return the name of the current pipe if different from the branch name.
#
# Usage: bzr_pipe_if_different [path]
#
bzr_pipe_if_different() {
    local path
    [ "$1" ] && path="$1" || path="$PWD"
    if _bzr_is_lw_checkout "$path"; then
        local dir=$(basename "$path")
        local pipe=$(_bzr_current_pipe "$path")
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

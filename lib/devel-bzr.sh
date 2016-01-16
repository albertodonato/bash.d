# -*- mode: sh -*-

#
# Whether the dir is a bzr lightweight checkout
#
# Usage: bzr_is-lw_checkout [path]
#
bzr_is_lw_checkout() {
    _bzr_info "$1" | grep -q "light checkout"
}

#
# Return the name of the current pipe in the pipeline
#
# Usage: bzr_current_pipe [path]
#
bzr_current_pipe() {
    bzr pipes "$1" | awk '/^\*/ { print $2; }'
}
   
#
# Return the name of the current pipe if different from the branch name
#
# Usage: bzr_pipe_if_different [path]
#
bzr_pipe_if_different() {
    if bzr_is_lw_checkout "$1"; then
        local dir=$(basename "$1")
        local pipe=$(bzr_current_pipe "$1")
        [ "$dir" != "$pipe" ] && echo "$pipe"
    fi
}

#
# Return a list of bzr pipes in the pipeline, with their diff size.
#
# Usage: bzr_pipes_size
#
bzr_pipes_size() {
    local pipe prev_pipe revspec

    for pipe in $(bzr pipes | awk '{print $NF;}'); do
        [ "$prev_pipe" ] && revspec=":pipe:$prev_pipe" || revspec="ancestor:"
        revspec+="..:pipe:$pipe"

        local lines=$(bzr diff -r $revspec 2>/dev/null | wc -l)
        printf "%4d %s\n" $lines $pipe
        prev_pipe=$pipe
    done
}

_bzr_info() {
    bzr info "$1" 2>/dev/null
}

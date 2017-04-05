# -*- mode: sh -*-
#
# Autocompletion configuration
#

if is_interactive; then
    source_if_exists /etc/bash_completion

    _s() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local sources="$(ls -1 $SYSTEM_DIR/source)"
        COMPREPLY=( $(compgen -W "$sources" -- "$cur") )
    }
    complete -F _s s

    _ve() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local sources="$(ls -1 $HOME/virtualenv)"
        COMPREPLY=( $(compgen -W "$sources" -- "$cur") )
    }
    complete -F _ve ve
fi

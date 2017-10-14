# -*- mode: sh -*-
#
# Autocompletion configuration


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

    _ssh_lxd() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local sources="$(lxc list --columns=ns | awk '$4 == "RUNNING" { print $2; }')"
        COMPREPLY=( $(compgen -W "$sources" -- "$cur") )
    }
    complete -F _ssh_lxd ssh-lxd


    _prompt_set() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local sources="basic normal nocolor extended"
        COMPREPLY=( $(compgen -W "$sources" -- "$cur") )
    }
    complete -F _prompt_set prompt_set
fi

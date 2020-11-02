# -*- mode: sh -*-
#
# Autocompletion configuration


if is_interactive; then
    source_if_exists /etc/bash_completion

    _bcomp_s() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local sources
        sources=$(ls -1 "$SYSTEM_DIR/source")
        mapfile -t COMPREPLY < <(compgen -W "$sources" -- "$cur")
    }
    complete -F _bcomp_s s

    _bcomp_ve() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local sources
        sources=$(ls -1 "$HOME/virtualenv")
        mapfile -t COMPREPLY < <(compgen -W "$sources" -- "$cur")
    }
    complete -F _bcomp_ve ve

    _bcomp_ssh_lxd() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local sources
        sources="$(lxc list --columns=ns | awk '$4 == "RUNNING" { print $2; }')"
        mapfile -t COMPREPLY < <(compgen -W "$sources" -- "$cur")
    }
    complete -F _bcomp_ssh_lxd ssh-lxd


    _bcomp_prompt_set() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local sources="basic normal nocolor extended"
        mapfile -t COMPREPLY < <(compgen -W "$sources" -- "$cur")
    }
    complete -F _bcomp_prompt_set prompt_set

    _bcomp_wakeup() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local sources
        sources="$(wakeup)"
        mapfile -t COMPREPLY < <(compgen -W "$sources" -- "$cur")
    }
        complete -F _bcomp_wakeup wakeup
fi

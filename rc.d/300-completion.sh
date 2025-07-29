# Autocompletion configuration

# only load completion for interactive shells
if [[ $- == *i* ]]; then
    source_if_exists /etc/bash_completion
    if [ -d "$HOME"/.bash_completion.d ]; then
        source_many "$HOME"/.bash_completion.d/*
    fi

    _bcomp_s() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local sources
        sources=$(ls -1 "$SYSTEM_DIR/source")
        mapfile -t COMPREPLY < <(compgen -W "$sources" -- "$cur")
    }
    complete -F _bcomp_s s

    _bcomp_prompt_set() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local sources="basic extended nocolor oneline"
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

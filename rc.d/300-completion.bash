# Autocompletion configuration


# Load completers from file.
#
# Each line is a completer command plus program(s) the complation is for, or
# just the command if it generates completions for itself.
load_completers() {
    local conf_file="$SHELL_D_CONF/bash-completion-completers.txt"

    if [ ! -f "$conf_file" ]; then
        return
    fi

    local line completer names name
    while IFS= read -r line; do
        read -r completer names <<<"$line"
        if [ -z "$names" ]; then
            names="$completer"
        fi

        for name in $names; do
            complete -C "$completer" "$name"
        done
    done <"$conf_file"
}

# only load completion for interactive shells
if [[ $- == *i* ]]; then
    source_if_exists /etc/bash_completion

    load_completers
    load_evals

    # completions for commands from the repository

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

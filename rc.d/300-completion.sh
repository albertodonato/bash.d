# Autocompletion configuration


_have_command() {
    command -v "$1" >/dev/null
}

# Load eval commands from file.
#
# Each line of the file is a command to run and eval output for.
_load_evals() {
    local conf_file="${SHELL_D_CONF}/bash-evals.txt"

    if [ ! -f "$conf_file" ]; then
        return
    fi

    local cmdline cmd
    while IFS= read -r cmdline; do
        cmd="${cmdline%% *}"
        if ! _have_command "$cmd"; then
            continue
        fi
        eval "$($cmdline)"
    done <"$conf_file"
}

# Load completers from file.
#
# Each line is a completer command plus program(s) the complation is for, or
# just the command if it generates completions for itself.
_load_completers() {
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
    _source_if_exists /etc/bash_completion

    _load_completers
    _load_evals

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

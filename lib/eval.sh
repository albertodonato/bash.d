# Commands-based evaluation helpers


# Does a command with the name exist
have_command() {
    command -v "$1" >/dev/null
}

# Load eval commands from file.
#
# Each line of the file is a command to run and eval output for.
load_evals() {
    local conf_file="${SHELL_D_CONF}/${SHELL_D_SHELL}-evals.txt"

    if [ ! -f "$conf_file" ]; then
        return
    fi

    local cmdline cmd
    while IFS= read -r cmdline; do
        cmd="${cmdline%% *}"
        if ! have_command "$cmd"; then
            continue
        fi
        eval "$($cmdline)"
    done <"$conf_file"
}

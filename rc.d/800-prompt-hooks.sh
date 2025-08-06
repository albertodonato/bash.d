# Hooks for setting prompt elements


# Return the type of container of the host.
container_type() {
    local type file
    for file in /run/container_type /run/systemd/container; do
        [ -f "$file" ] && type=$(cat "$file")
    done

    echo "$type"
}

# Return a git reference (if available for the prompt)
git_prompt_ref() {
    local ref hash
    ref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    hash=$(git rev-parse --short HEAD 2>/dev/null)
    if [ -n "$hash" ] && [ -n "$ref" ]; then
        echo "${ref}(${hash})"
    fi
}


prompt_set_flag container red "$(container_type)"

prompt_set_hook git yellow 'git_prompt_ref'
# shellcheck disable=SC2016
prompt_set_hook go yellow '[ "$GOPATH" != "$HOME/go" ] && echo $GOPATH'
# shellcheck disable=SC2016
prompt_set_hook ve red '[ "$VIRTUAL_ENV" ] && echo $(basename $VIRTUAL_ENV)'

# shellcheck disable=SC2016
prompt_set extended

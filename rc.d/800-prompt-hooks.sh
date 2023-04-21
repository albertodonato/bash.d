# Hooks for setting prompt elements


prompt_set_flag container solarized.yellow "$(container_type)"
prompt_set_hook git solarized.orange 'git_prompt_ref'
# shellcheck disable=SC2016
prompt_set_hook go solarized.yellow '[ "$GOPATH" != "$HOME/go" ] && echo $GOPATH'
# shellcheck disable=SC2016
prompt_set_hook ve solarized.red '[ -n "$VIRTUAL_ENV" ] && echo $(basename $VIRTUAL_ENV)'
prompt_set extended

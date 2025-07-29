# Hooks for setting prompt elements


prompt_set_flag container red "$(container_type)"
prompt_set_hook git yellow 'git_prompt_ref'
# shellcheck disable=SC2016
prompt_set_hook go yellow '[ "$GOPATH" != "$HOME/go" ] && echo $GOPATH'
# shellcheck disable=SC2016
prompt_set_hook ve red '[ -n "$VIRTUAL_ENV" ] && echo $(basename $VIRTUAL_ENV)'
# shellcheck disable=SC2016
prompt_set_hook nix-shell lightred '[ -n "$IN_NIX_SHELL" ] && echo nis-shell'
prompt_set extended

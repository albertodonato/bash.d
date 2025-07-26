# Hooks for setting prompt elements


prompt_set_flag container nord12 "$(container_type)"
prompt_set_hook git nord13 'git_prompt_ref'
# shellcheck disable=SC2016
prompt_set_hook go nord13 '[ "$GOPATH" != "$HOME/go" ] && echo $GOPATH'
# shellcheck disable=SC2016
prompt_set_hook ve nord11 '[ -n "$VIRTUAL_ENV" ] && echo $(basename $VIRTUAL_ENV)'
# shellcheck disable=SC2016
prompt_set_hook nix-shell nord11 '[ -n "$IN_NIX_SHELL" ] && echo nis-shell'
prompt_set extended

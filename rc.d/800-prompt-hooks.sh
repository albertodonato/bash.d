# -*- mode: sh -*-
#
# Hooks for setting prompt elements


prompt_set_flag container solarized.yellow "$(container_type)"
prompt_set_hook git solarized.orange "git rev-parse --abbrev-ref HEAD 2>/dev/null"
# shellcheck disable=SC2016
prompt_set_hook go solarized.yellow '[ "$GOPATH" != "$HOME/go" ] && echo $GOPATH'
prompt_set extended

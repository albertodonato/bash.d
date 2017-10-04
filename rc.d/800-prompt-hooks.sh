# -*- mode: sh -*-
#
# Hooks for setting prompt elements
#

prompt_set_flag container solarized.yellow "$(container_type)"
prompt_set_hook bzr solarized.orange "bzr_pipe_if_different"
prompt_set_hook git solarized.orange "git rev-parse --abbrev-ref HEAD 2>/dev/null"
prompt_set_hook go solarized.yellow '[ "$GOPATH" != "$HOME/go" ] && echo $GOPATH'
prompt_set extended

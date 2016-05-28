# -*- mode: sh -*-
#
# Hooks for setting prompt elements
#

prompt_set_flag container yellow "$(container_type)"
prompt_set_hook bzr lightmagenta "bzr_pipe_if_different"
prompt_set_hook git lightmagenta "git rev-parse --abbrev-ref HEAD 2>/dev/null"
prompt_set extended

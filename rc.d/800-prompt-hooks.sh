# -*- mode: sh -*-
#
# Hooks for setting prompt elements
#

set_prompt extended
set_prompt_info container darkred "$(container_type)"
set_prompt_hook bzr magenta "bzr_pipe_if_different"
set_prompt_hook git magenta "git rev-parse --abbrev-ref HEAD 2>/dev/null"

# -*- mode: sh -*-
#
# Hooks for setting prompt elements
#

set_prompt_flag container yellow "$(container_type)"
set_prompt_hook bzr lightmagenta "bzr_pipe_if_different"
set_prompt_hook git lightmagenta "git rev-parse --abbrev-ref HEAD 2>/dev/null"
set_prompt extended

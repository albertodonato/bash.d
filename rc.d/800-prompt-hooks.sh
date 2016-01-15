# -*- mode: sh -*-
#
# Hooks for setting prompt elements
#

set_prompt extended
set_prompt_info container '2;49;33' "$(container_type)"
set_prompt_hook bzr '1;49;35' "bzr_pipe_if_different \"\$PWD\""
set_prompt_hook git '1;49;35' "git rev-parse --abbrev-ref HEAD 2>/dev/null"

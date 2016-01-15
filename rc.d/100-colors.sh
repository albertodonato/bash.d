# -*- mode: sh -*-
#
# Terminal colors
#

eval $(dircolors)

# less colors
export LESS_TERMCAP_mb=$'\E[1;31m'        # begin blinking
export LESS_TERMCAP_md=$'\E[1;38;5;74m'   # begin bold
export LESS_TERMCAP_so=$'\E[1;31;246m'    # begin standout-mode
export LESS_TERMCAP_us=$'\E[4;38;5;146m'  # begin underline
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode

# -*- mode: sh -*-
#
# Terminal colors.


eval $(dircolors)

# Colors for less
# blink/bold
export LESS_TERMCAP_mb="$(term_color yellow bold)"
export LESS_TERMCAP_md="$(term_color white bold)"
export LESS_TERMCAP_me="$(term_color)"
# standout
export LESS_TERMCAP_so="$(term_color red bold)"
export LESS_TERMCAP_se="$(term_color)"
# underline
export LESS_TERMCAP_us="$(term_color white underline)"
export LESS_TERMCAP_ue="$(term_color)"

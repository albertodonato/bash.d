# -*- mode: sh -*-
#
# Terminal colors.


eval "$(dircolors)"

# Colors for less
# blink/bold
LESS_TERMCAP_mb="$(term_color yellow bold)"
LESS_TERMCAP_md="$(term_color white bold)"
LESS_TERMCAP_me="$(term_color)"
# standout
LESS_TERMCAP_so="$(term_color red bold)"
LESS_TERMCAP_se="$(term_color)"
# underline
LESS_TERMCAP_us="$(term_color white underline)"
LESS_TERMCAP_ue="$(term_color)"

export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_so \
       LESS_TERMCAP_se LESS_TERMCAP_us LESS_TERMCAP_ue

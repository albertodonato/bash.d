# Shell history setup

shopt -s histappend

PROMPT_COMMAND="history -a; history -r"

HISTFILESIZE=100000

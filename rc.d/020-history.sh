# Shell history setup

shopt -s histappend

export PROMPT_COMMAND="history -a; history -r"

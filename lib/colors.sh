# -*- mode: sh -*-
#
# Helper functions for coloring escape codes.
#

declare -gA _term_colors=(
    [solarized.base03]='00;38;5;234'
    [solarized.base02]='00;38;5;235'
    [solarized.base01]='00;38;5;240'
    [solarized.base3]='00;38;5;234'
    [solarized.base2]='00;38;5;234'
    [solarized.base1]='00;38;5;245'
    [solarized.yellow]='00;38;5;136'
    [solarized.orange]='00;38;5;166'
    [solarized.red]='00;38;5;160'
    [solarized.magenta]='00;38;5;125'
    [solarized.violet]='00;38;5;61'
    [solarized.blue]='00;38;5;33'
    [solarized.cyan]='00;38;5;37'
    [solarized.green]='00;38;5;64'
    [yellow]='1;49;33'
    [blue]='1;49;34'
    [green]='5;49;32'
    [red]='0;49;31'
    [darkred]='2;49;33'
    [gray]='1;49;90'
    [magenta]='1;49;35'
)

#
# Return the escape string for a color name or code. 
#
term_color() {
    local escape=${_term_colors[$1]}
    [ "$escape" ] || escape=$1
    _term_color_escape $escape
}

#
# Reset color attributes.
#
term_color_reset() {
    _term_color_escape
}

#
# Print the escape for a specified term color.
#
_term_color_escape() {
    local color="0"
    [ "$1" ] && color="$1"

    echo "\\[\\033[${color}m\\]"
}

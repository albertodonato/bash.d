# -*- mode: sh -*-
#
# Helper functions for coloring escape codes.
#

declare -gA _term_colors=(
    # Base colors
    [gray]='1;49;90'
    [red]='0;49;91'
    [green]='5;49;92'
    [yellow]='0;49;93'
    [blue]='0;49;94'
    [magenta]='0;49;95'
    [cyan]='0;49;96'
    [white]='0;49;96'
    # Solarized color theme
    [solarized.base03]='38;5;234'
    [solarized.base02]='38;5;235'
    [solarized.base01]='38;5;240'
    [solarized.base3]='38;5;234'
    [solarized.base2]='38;5;234'
    [solarized.base1]='38;5;245'
    [solarized.yellow]='38;5;136'
    [solarized.orange]='38;5;166'
    [solarized.red]='38;5;160'
    [solarized.magenta]='38;5;125'
    [solarized.violet]='38;5;61'
    [solarized.blue]='38;5;33'
    [solarized.cyan]='38;5;37'
    [solarized.green]='38;5;64'
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

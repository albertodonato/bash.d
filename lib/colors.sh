# -*- mode: sh -*-
#
# Helper functions for coloring escape codes.
#

declare -gA _term_colors=(
    # Base colors
    [black]='38;5;0'
    [red]='38;5;1'
    [green]='38;5;2'
    [yellow]='38;5;3'
    [blue]='38;5;4'
    [magenta]='38;5;5'
    [cyan]='38;5;6'
    [gray]='38;5;7'
    [darkgray]='38;5;8'
    [lightred]='38;5;9'
    [lightgreen]='38;5;10'
    [lightyellow]='38;5;11'
    [lightblue]='38;5;12'
    [lightmagenta]='38;5;13'
    [lightcyan]='38;5;14'
    [white]='38;5;15'
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
    _term_color_escape 0
}

#
# Print the escape for a specified term color.
#
_term_color_escape() {
    echo "\\[\\033[${1}m\\]"
}

# Helper functions for terminal color escape codes.


declare -gA _colors=(
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
)

# Return the escape string for a color name or code. 
term_color() {
    local code

    [ -n "$1" ] && code=$(_get_color_code "$@") || code=0

    printf "\\e[%sm" "$code"
}

# Return the escape string for a prompt color.
prompt_color() {
    local code

    [ -n "$1" ] && code=$(_get_color_code "$@") || code=0

    printf "\\[\\033[%sm\\]" "$code"
}

_get_color_code() {
    local value="$1"
    local modifier="$2"
    local -A modifiers=(
        [bold]='1'
        [dim]='2'
        [reverse]='3'
        [underline]='4'
    )
    local escape="${_colors[$value]}"

    if [ -n "$escape" ]; then
        # value is a color number, possibly add modifier
        [ -n "$modifier" ] && escape="${modifiers[$modifier]};$escape"
    else
        # value is a plain code
        escape="$value"
    fi
    echo "$escape"
}

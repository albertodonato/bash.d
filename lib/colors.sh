# Helper functions for terminal color escape codes.


declare -gA _colors=(
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
    [solarized.base00]='38;5;241'
    [solarized.base0]='38;5;244'
    [solarized.base1]='38;5;245'
    [solarized.base2]='38;5;254'
    [solarized.base3]='38;5;230'
    [solarized.yellow]='38;5;136'
    [solarized.orange]='38;5;166'
    [solarized.red]='38;5;160'
    [solarized.magenta]='38;5;125'
    [solarized.violet]='38;5;61'
    [solarized.blue]='38;5;33'
    [solarized.cyan]='38;5;37'
    [solarized.green]='38;5;64'
    # Nord color theme
    [nord0]="38;2;46;52;64"
    [nord1]="38;2;59;66;82"
    [nord2]="38;2;67;76;94"
    [nord3]="38;2;76;86;106"
    [nord4]="38;2;216;222;233"
    [nord5]="38;2;229;233;240"
    [nord6]="38;2;236;239;244"
    [nord7]="38;2;143;188;187"
    [nord8]="38;2;136;192;208"
    [nord9]="38;2;129;161;193"
    [nord10]="38;2;94;129;172"
    [nord11]="38;2;191;97;106"
    [nord12]="38;2;208;135;112"
    [nord13]="38;2;235;203;139"
    [nord14]="38;2;163;190;140"
    [nord15]="38;2;180;142;173"
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

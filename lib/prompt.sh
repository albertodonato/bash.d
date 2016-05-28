# -*- mode: sh -*-
#
# Prompt-related functions.
#
# Three prompt formats are currently supported (as arguments to 'set_prompt'):
#
# - basic:
#    $ _
#
# - normal:
#    user@host /current/path $ _
#
# - extended (default):
#    R user@host /current/path [info|...] key:val ...
#    $ _
#
#   where elements are as follows:
#    * R: the return vlaue of the previous command
#    * info: indicator strings that can be added/removed manually
#    * key:val: sequence of key/value elements where the value is computed at
#       each run by calling the provided function. These are sorted
#       alpabetically by key
#

declare -gA _prompt_flags=()
declare -gA _prompt_flag_prefixes=()
declare -gA _prompt_flag_colors=()
declare -gA _prompt_hooks=()
declare -gA _prompt_hook_colors=()

#
# Set or update a flag in the prompt, optionally with a prefix.
#
# Usage: set_prompt_flag <name> <color> <value> [prefix]
#
set_prompt_flag() {
    local name="$1"
    local color="$2"
    local value="$3"
    local prefix="$4"
    [ "$value" ] || return

    _prompt_flags[$name]="$value"
    _prompt_flag_prefixes[$name]="$prefix"
    _prompt_flag_colors[$name]="$color"
}

#
# Unset the prompt flag with the specified name.
#
# Usage: unset_prompt_flag <name>
#
unset_prompt_flag() {
    unset _prompt_flags["$1"]
    unset _prompt_flag_prefixes["$1"]
    unset _prompt_flag_colors["$1"]
}

#
# List prompt flags.
#
list_prompt_flags() {
    echo ${!_prompt_flags[@]} | sed 's/ /\n/g' | sort
}

#
# Set a dynamic prompt hook.
#
# Usage: set_prompt_hook <name> <color> <hook_function>
#
set_prompt_hook() {
    local name="$1"
    local color="$2"
    local func="$3"
    _prompt_hooks[$name]="$func"
    _prompt_hook_colors[$name]="$color"
}

#
# Unset the prompt hook with the specified name.
#
# Usage: unset_prompt_hook <name>
#
unset_prompt_hook() {
    unset _prompt_hooks["$1"]
    unset _prompt_hook_colors["$1"]
}

#
# List prompt hooks.
#
list_prompt_hooks() {
    echo ${!_prompt_hooks[@]} | sed 's/ /\n/g' | sort
}

#
# Reset the prompt based on the configuration for the given template.
#
# By default, exended prompt is used.
#
# Usage: set_prompt [basic|extended]
#
set_prompt() {
    local reset="$(prompt_color)"
    local user="$(prompt_color lightyellow)"
    local host="$(prompt_color lightblue)"
    local path="$(prompt_color lightgreen)"
    local retval="$(prompt_color lightred)"
    local prompt="$(prompt_color darkgray)"

    local ps1
    case $1 in
        basic)
            ps1="${prompt}\$${reset} "
            ;;
        normal)
            ps1="${user}\u${host}@\h ${path}\w ${prompt}\$${reset} "
            ;;
        extended|*)
            ps1="${retval}\$(printf '%3d' \$?) ${user}\u${host}@\h ${path}\w${reset}"
            ps1+="\$(_render_prompt_flags)"
            ps1+="\$(_render_prompt_hooks)"
            # input goes on a new line
            ps1+="\n${prompt}\$${reset} "
            ;;
    esac

    # Prefix for terminal title
    local termtitle
    case $TERM in
        xterm*|rxvt*)
            termtitle="\[\e];\l - \H:\w\a\]"
            ;;
    esac

    PS1="$termtitle$ps1"
}

_render_prompt_flags() {
    local name output

    for name in $(list_prompt_flags); do
        [ "$output" ] && output+="|"
        output+="$(_render_prompt_flag $name)"
    done

    [ "$output" ] && echo " [$output]"
}

_render_prompt_flag() {
    local name="$1"
    local prefix="${_prompt_flag_prefixes[$name]}"
    local color="${_prompt_flag_colors[$name]}"
    local value="${_prompt_flags[$name]}"

    local output="$(term_color $color)$value$(term_color)"
    [ "$prefix" ] && output="$prefix:$output"
    echo "$output"
}

_render_prompt_hooks() {
    local output name value

    for name in $(list_prompt_hooks); do
        value="$(_render_prompt_hook $name)"
        [ "$value" ] && output+=" $value"
    done

    echo -e "$output"
}

_render_prompt_hook() {
    local name="$1"
    local color="${_prompt_hook_colors[$name]}"
    local func="${_prompt_hooks[$name]}"

    local output="$(eval $func)"
    [ "$output" ] && echo "$name:$(term_color $color)$output$(term_color)"
}

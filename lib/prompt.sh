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

declare -gA _ps1_elements
declare -gA _ps1_info

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

    value="$(term_color $color)$value$(term_color_reset)"
    [ "$prefix" ] && value="$prefix:$value"
    _ps1_info[$name]="$value"
    set_prompt
}

#
# Unset the prompt flag with the specified name.
#
# Usage: unset_prompt_flag <name>
#
unset_prompt_flag() {
    unset _ps1_info["$1"]
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
    _ps1_elements[$name]="\$(f() { local value=\"\$($func)\"; [ \"\$value\" ] && echo \"$name:$(term_color $color)\$value$(term_color_reset)\"; }; f)"
    set_prompt
}

#
# Unset the prompt hook with the specified name.
#
# Usage: unset_prompt_hook <name>
#
unset_prompt_hook() {
    unset _ps1_elements["$1"]
}

#
# Reset the prompt based on the configuration for the given template.
#
# By default, exended prompt is used.
#
# Usage: set_prompt [basic|extended]
#
set_prompt() {
    local reset="$(term_color_reset)"
    local user="$(term_color lightyellow)"
    local host="$(term_color lightblue)"
    local path="$(term_color lightgreen)"
    local retval="$(term_color lightred)"
    local prompt="$(term_color darkgray)"

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
            local key keys

            # add info elements
            keys="$(echo ${!_ps1_info[@]} | sed 's/ /\n/g' | sort)"
            local info
            for key in $keys; do
                [ "$info" ] && info+="|"
                info+="${_ps1_info[$key]}"
            done
            [ "$info" ] && ps1+=" [$info]"

            # add keyed elements
            keys="$(echo ${!_ps1_elements[@]} | sed 's/ /\n/g' | sort)"
            for key in $keys; do
                [ "${_ps1_elements[$key]}" ] && ps1+=" ${_ps1_elements[$key]}"
            done

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

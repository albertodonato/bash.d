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
#    R user@host /current/path [info|...] elem:val... hook:val ...
#    $ _
#
#   where elements are as follows:
#    * R: the return vlaue of the previous command
#    * info: indicator strings that can be added/removed manually
#    * elem: sequence of key:value elements
#    * hook: sequence of key:value elements where the value is computed at each
#       run by calling the provided function
#
#   Key/value elements (both static and hooks) are sorted alphabetically
#

declare -gA _ps1_elements
declare -gA _ps1_info

#
# Add or update a prompt element.
#
# Usage: set_prompt_element <name> <color> <value>
#
set_prompt_element() {
    local name="$1"
    local color="$2"
    local value="$3"
    [ "$value" ] || return

    _ps1_elements[$name]="$name:$(_term_color_escape $color)$value$(_term_color_escape)"
    set_prompt
}

#
# Unset the prompt element with the specified name.
#
# Usage: unset_prompt_element <name>
#
unset_prompt_element() {
    unset _ps1_elements["$1"]
}

#
# Set or update a prompt info element, optionally with a prefix.
#
# Usage: set_prompt_info <name> <color> <value> [prefix]
#
set_prompt_info() {
    local name="$1"
    local color="$2"
    local value="$3"
    local prefix="$4"
    [ "$value" ] || return

    value="$(_term_color_escape $color)$value$(_term_color_escape)"
    [ "$prefix" ] && value="$prefix:$value"
    _ps1_info[$name]="$value"
    set_prompt
}

#
# Unset the prompt info element with the specified name.
#
# Usage: unset_prompt_info <name>
#
unset_prompt_info() {
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
    _ps1_elements[$name]="\$(f() { local value=\"\$($func)\"; [ \"\$value\" ] && echo \"$name:$(_term_color_escape $color)\$value$(_term_color_escape)\"; }; f)"
    set_prompt
}

#
# Reset the prompt based on the configuration for the given template.
#
# By default, exended prompt is used.
#
# Usage: set_prompt [basic|extended]
#
set_prompt() {
    local reset=$(term_color_reset)
    local user="$(term_color solarized.yellow)"
    local host="$(term_color solarized.violet)"
    local path="$(term_color solarized.green)"
    local retval="$(term_color solarized.red)"
    local prompt="$(term_color solarized.base1)"

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

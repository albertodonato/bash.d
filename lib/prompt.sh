# -*- mode: sh -*-
#
# Prompt-related functions.
#
# Two prompt formats are currently supported (as arguments to 'set_prompt'):
#
# - basic:
#    user@host /current/path $
#
# - extended:
#    R user@host /current/path [info|...] elem:val... hook:val ...
#    $
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

declare -gA ps1_elements
declare -gA ps1_info

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

    ps1_elements[$name]="$name:$(_term_color $color)$value$(_term_color)"
    set_prompt
}

#
# Unset the prompt element with the specified name.
#
# Usage: unset_prompt_element <name>
#
unset_prompt_element() {
    unset ps1_elements["$1"]
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

    value="$(_term_color $color)$value$(_term_color)"
    [ "$prefix" ] && value="$prefix:$value"
    ps1_info[$name]="$value"
    set_prompt
}

#
# Unset the prompt info element with the specified name.
#
# Usage: unset_prompt_info <name>
#
unset_prompt_info() {
    unset ps1_info["$1"]
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
    ps1_elements[$name]="\$(f() { local value=\"\$($func)\"; [ \"\$value\" ] && echo \"$name:$(_term_color $color)\$value$(_term_color)\"; }; f)"
    set_prompt
}

#
# Reset the prompt based on the configuration for the given template.
#
# By default, exended prompt is used.
#
# Usage; set_prompt [basic|extended]
#
set_prompt() {
    local reset=$(_term_color)
    local user="$(_term_color '1;49;33')"
    local host="$(_term_color '1;49;34')"
    local path="$(_term_color '5;49;32')"
    local retval="$(_term_color '0;49;31')"
    local prompt="$(_term_color '1;49;90')"

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
            keys="$(echo ${!ps1_info[@]} | sed 's/ /\n/g' | sort)"
            local info
            for key in $keys; do
                [ "$info" ] && info+="|"
                info+="${ps1_info[$key]}"
            done
            [ "$info" ] && ps1+=" [$info]"

            # add keyed elements
            keys="$(echo ${!ps1_elements[@]} | sed 's/ /\n/g' | sort)"
            for key in $keys; do
                [ "${ps1_elements[$key]}" ] && ps1+=" ${ps1_elements[$key]}"
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

_term_color() {
    local color="0"
    [ "$1" ] && color="$1"

    echo "\\[\\033[${color}m\\]"
}

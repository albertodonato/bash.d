# Prompt-related functions.
#
# Three prompt formats are currently supported (as arguments to 'prompt_set'):
#
# - basic:
#    $ _
#
# - normal:
#    user@host /current/path $ _
#
# - nocolor:
#    user@host /current/path $ _
#
#   this is the same as "normal", but without colors
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


declare -gA _prompt_flags=()
declare -gA _prompt_flag_prefixes=()
declare -gA _prompt_flag_colors=()
declare -gA _prompt_hooks=()
declare -gA _prompt_hook_colors=()

# Set or update a flag in the prompt, optionally with a prefix.
prompt_set_flag() {
    local name="$1"
    local color="$2"
    local value="$3"
    local prefix="$4"

    [ -n "$value" ] || return

    _prompt_flags[$name]="$value"
    _prompt_flag_prefixes[$name]="$prefix"
    _prompt_flag_colors[$name]="$color"
}

# Unset the prompt flag with the specified name.
prompt_unset_flag() {
    local name="$1"

    unset "_prompt_flags[$name]"
    unset "_prompt_flag_prefixes[$name]"
    unset "_prompt_flag_colors[$name]"
}

# List prompt flags.
prompt_list_flags() {
    echo "${!_prompt_flags[@]}" | sed 's/ /\n/g' | sort
}

# Set a dynamic prompt hook.
prompt_set_hook() {
    local name="$1"
    local color="$2"
    local func="$3"

    _prompt_hooks[$name]="$func"
    _prompt_hook_colors[$name]="$color"
}

# Unset the prompt hook with the specified name.
prompt_unset_hook() {
    local name="$1"

    unset "_prompt_hooks[$name]"
    unset "_prompt_hook_colors[$name]"
}

# List prompt hooks.
prompt_list_hooks() {
    echo "${!_prompt_hooks[@]}" | sed 's/ /\n/g' | sort
}

# Set prompt based on a profile.
#
# Available profiles are:
#  - basic
#  - normal
#  - extended
#
# By default, the 'exended' profile is used is used.
prompt_set() {
    local prompt_type="$1"

    local reset user host path retval prompt
    reset="$(prompt_color)"
    user="$(prompt_color yellow)"
    host="$(prompt_color solarized.blue)"
    path="$(prompt_color solarized.green)"
    retval="$(prompt_color solarized.red)"
    prompt="$(prompt_color solarized.base0)"

    local ps1
    case "$prompt_type" in
        basic)
            ps1="${prompt}\$${reset} "
            ;;
        nocolor)
            ps1='\u@\h \w \$ '
            ;;
        normal)
            ps1="${user}\u${host}@\h ${path}\w ${prompt}\$${reset} "
            ;;
        extended|*)
            ps1="${retval}\$(printf '%3d' \$?) ${user}\u${host}@\h ${path}\w${reset}"
            ps1+="\$(_prompt_render_flags)"
            ps1+="\$(_prompt_render_hooks)"
            # input goes on a new line
            ps1+="\\n${prompt}\$${reset} "
            ;;
    esac

    # Prefix for terminal title
    local termtitle
    case $TERM in
        xterm*|rxvt*)
            termtitle='\[\e];\l - \H:\w\a\]'
            ;;
    esac

    PS1="$termtitle$ps1"
}

_prompt_render_flags() {
    local name output

    for name in $(prompt_list_flags); do
        [ -n "$output" ] && output+="|"
        output+=$(_prompt_render_flag "$name")
    done

    [ -n "$output" ] && echo " [$output]"
}

_prompt_render_flag() {
    local name="$1"

    local color_code output
    local prefix="${_prompt_flag_prefixes[$name]}"
    local color="${_prompt_flag_colors[$name]}"
    local value="${_prompt_flags[$name]}"
    color_code=$(term_color "$color")
    output="$color_code$value$(term_color)"
    [ -n "$prefix" ] && output="$prefix:$output"
    echo "$output"
}

_prompt_render_hooks() {
    local output name value

    for name in $(prompt_list_hooks); do
        value=$(_prompt_render_hook "$name")
        [ -n "$value" ] && output+=" $value"
    done

    echo -e "$output"
}

_prompt_render_hook() {
    local name="$1"

    local color func output color_code
    color="${_prompt_hook_colors[$name]}"
    func="${_prompt_hooks[$name]}"
    output=$(eval "$func")
    color_code=$(term_color "$color")

    [ -n "$output" ] && echo "$name:$color_code$output$(term_color)"
}

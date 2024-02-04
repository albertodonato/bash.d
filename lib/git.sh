# shellcheck disable=SC2039
#
# Utility functions for Git.


# Return a git reference (if available for the prompt)
git_prompt_ref() {
    local ref hash
    hash=$(git rev-parse --short HEAD 2>/dev/null)
    ref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$hash" ] && [ -n "$ref" ]; then
        echo "$hash|$ref"
    fi
}

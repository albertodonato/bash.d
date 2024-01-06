# shellcheck disable=SC1090
#
# Hook for containers login setup


if [ "$(container_type)" = "lxc" ]; then
    # Use the same ssh agent for all SSH connections.
    agent_source_file=/tmp/ssh-agent.source

    if [ ! -f $agent_source_file ]; then
        ssh-agent -s | grep -v 'Agent pid' >"$agent_source_file"
    fi
    . "$agent_source_file"

    unset agent_source_file
fi

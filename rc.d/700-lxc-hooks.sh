# -*- mode: sh -*-
#
# Hook for LXC login setup
#

if [ "$(lxc-name)" ]; then
    # Use the same ssh agent for all SSH connections.
    agent_source_file=/tmp/ssh-agent.source

    if [ ! -f $agent_source_file ]; then
        ssh-agent -s >$agent_source_file
    fi
    . $agent_source_file

    unset agent_source_file
fi

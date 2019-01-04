# -*- mode: sh -*-
# shellcheck disable=SC2039
#
# Network-related functions.


# Return the IP of a nova instance by name.
nova_instance_ip() {
    local hostname="$1"

    if [ -z "$hostname" ]; then
        echo "Missing hostname"
        return 1
    fi
    nova list --name="$hostname" --status=active --fields=networks | \
        awk -F ' | ' '/=/ { split($4, a, "[=;]"); print a[2]; exit};'
}

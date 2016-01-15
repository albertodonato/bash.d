# -*- mode: sh -*-

#
# Return the IP of a nova instance by name.
#
# Usage: nova_instance_ip <name>
#
nova_instance_ip() {
    if [ ! "$1" ]; then
        echo "Missing hostname"
        return 1
    fi
    nova list --name="$1" --status=active --fields=networks | \
        awk -F ' | ' '/=/ { split($4, a, "[=;]"); print a[2]; exit};'
}

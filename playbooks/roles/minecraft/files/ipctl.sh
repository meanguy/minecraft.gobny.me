#! /usr/bin/env bash

action=

function usage() {
    echo "Usage: $0 (ban|unban) <ip>"

    exit 1
}

if [ $# -ne 2 ]; then
    usage
fi

case $1 in
    ban)
        action=1
        ;;
    unban)
        action=0
        ;;
    *)
        usage
        ;;
esac

iptables ${action} INPUT -s $2 -j DROP
iptables ${action} FORWARD -d $2 -j DROP
iptables ${action} OUTPUT -d $2 -j DROP

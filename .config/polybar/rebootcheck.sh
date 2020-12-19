#!/bin/sh

if test -f "/var/run/reboot-required"; then
    echo "Reboot required"
else
    echo ""
fi

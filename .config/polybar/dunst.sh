#!/bin/sh
if $(dunstctl is-paused) == "true"
then
    echo DND
else
    echo
fi

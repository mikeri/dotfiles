#!/bin/sh
# export XDG_MENU_PREFIX=i3-
feh --bg-center ~/Pictures/weyland-yutani.jpg
alacritty --title "i3float" --option window.dimensions.lines=5 --option window.dimensions.columns=50 -e ssh-add && backupcheck

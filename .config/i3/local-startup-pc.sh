#!/bin/sh
# export XDG_MENU_PREFIX=i3-
xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate normal
setxkbmap no
feh --bg-center ~/Pictures/weyland-yutani.jpg
alacritty -title "i3float" --option window.dimensions.lines=5 --option window.dimensions.columns=50 -e ssh-add && backupcheck

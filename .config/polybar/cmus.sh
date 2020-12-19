#!/bin/bash

prepend_zero () {
        seq -f "%02g" $1 $1
}

output=$(cmus-remote -C status)
artist=$(echo "$output" | grep "tag artist" | cut -c 12-)

if [[ $artist = *[!\ ]* ]]; then
        song=$(echo "$output" | grep title | cut -c 11-)
        position=$(echo "$output"| grep position | cut -c 10-)
        cmusstatus=$(echo "$output"| grep status | cut -c 8-)
        case $cmusstatus in 
            "playing")
                icon=""
                ;;
            "paused")
                icon=""
                ;;
        esac

        minutes1=$(prepend_zero $(($position / 60)))
        seconds1=$(prepend_zero $(($position % 60)))
        duration=$(echo "$output"| grep duration | cut -c 10-)
        minutes2=$(prepend_zero $(($duration / 60)))
        seconds2=$(prepend_zero $(($duration % 60)))
        # echo -n "$artist - $song [$minutes1:$seconds1/$minutes2:$seconds2]"
        echo -n "%{F#444} $icon%{F-} $artist - $song"
else
        echo
fi

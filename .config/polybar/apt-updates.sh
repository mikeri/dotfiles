#!/bin/bash

result=$(apt-get --just-print upgrade | grep -oP "(?<=)\d(?= upgraded)")
if [[ $result = 0 ]]; then
    echo ""
else
    echo $result
fi

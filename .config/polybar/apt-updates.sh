#!/bin/sh

result=$(apt list --upgradeable | tail -n+2 | wc -l)
if [[ $result = 0 ]]; then
    echo ""
else
    echo $result


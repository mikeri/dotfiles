#!/bin/sh

SERVER="mail.shish.org"
NETRC="~/.netrc"

inbox=$(curl -sf -n -X "STATUS INBOX (UNSEEN)" imaps://"$SERVER"/INBOX | tr -d -c "[:digit:]")

if [ "$inbox" ] && [ "$inbox" -gt 0 ]; then
    echo "$inbox"
else
    echo ""
fi

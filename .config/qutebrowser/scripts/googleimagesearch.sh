#!/bin/bash

echo "open -t https://www.google.com/searchbyimage?&image_url=$QUTE_URL" >> "$QUTE_FIFO"

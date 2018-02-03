#!/bin/bash
# Use this to apply updates from the repo to homedir

find . -path ./.git -prune , -type f -a -not -name update.sh -a -not -name apply.sh | while IFS= read -r -d '' file
do
    echo "Copying $file to homedir"
    cp --parents ~/$file .
done
echo "Done."

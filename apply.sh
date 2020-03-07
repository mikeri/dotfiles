#!/bin/bash
# Use this to apply updates from the repo to homedir

find . -path ./.gitignore -prune , -path ./.git -prune , -type f -a -not -name update.sh -a -not -name apply.sh -print0 | while IFS= read -r -d '' file
do
    echo "Copying $file to homedir"
    cp --parents $file ~ 
done
echo "Done."

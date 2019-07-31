#!/bin/bash
# Use this to fetch updates from the homedir to the repo

find . -path ./.git -prune , -type f -a -not -name update.sh -a -not -name apply.sh -print0 | while IFS= read -r -d '' file
do
    echo "Copying $file to repository"
   cp ~/$file $file
done
echo "Done."

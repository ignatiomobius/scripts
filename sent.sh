#!/bin/sh
FILES=$(for FILE in "$@"; do
echo "file://$(readlink -f $FILE)"
done | xargs | sed "s/ /,/g")
exec thunderbird -compose "attachment='$FILES'" 

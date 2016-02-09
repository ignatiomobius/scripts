#!/bin/sh
# ~/fix-eol.sh
# convert all js,css,html, and txt files from DOS to UNIX line endings
echo `pwd`
find . -type f -regex ".*\.\(js\|css\|html\|txt\|java\)" | xargs fromdos

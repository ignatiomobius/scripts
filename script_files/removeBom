#!/bin/sh

# hd -n 3 [filename] --- to display boms
# tail -c +4 UTF8 > UTF8.nobom --- emergency remove
for f in *
do
	sed -i '1 s/^\xef\xbb\xbf//' *.txt
done

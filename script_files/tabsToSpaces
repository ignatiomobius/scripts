#!/bin/sh
for f in *xml
do
	expand $f --tabs=4 > $f.new
	rm $f
	mv $f.new $f	
done

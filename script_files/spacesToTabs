#!/bin/sh
for f in *xml
do
	unexpand $f --tabs=2 > $f.new
	rm $f
	mv $f.new $f	
done

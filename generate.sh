#!/bin/sh

for l in $(cat source.list)
do
	echo $l
	newfile=$(basename $l)
	curl -s $l | grep -v "^#" | sed 's/^||//;s/\^$//' | cut -f 2 -d '#' -- | sed 's/^ //' > $newfile.tmp
done

cat *.tmp | sort | uniq > bandomain.list
rm -rf *.tmp
mv bandomain.list bandomain.txt
rm blockdomain[0-9]*
split -d -l 800000 bandomain.txt blockdomain
rm bandomain.txt

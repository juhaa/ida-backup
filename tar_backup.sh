#!/bin/bash
#
# Usage: sh tar_backup.sh [txt file of directories to backup]
#
# Nov 2016, Juha Mehtonen

while IFS= read -r folder
do

	name=${folder##*/}
	p=${folder%/*}
	snap="${p}/${name}.snar"
	tar0="${p}/${name}-0.tar"
	tar1="${p}/${name}-1.tar"

	echo "Compressing directory $folder"

	if [ ! -f "$snap" ] ; then
		echo "Snapshot file not found. Creating it..."
		echo "Level 0 backup not found. Creating it..."
		tar -g $snap -cvf $tar0 -C $p $name"/"
		echo "Created snapshot file $snap"
		echo "Created level 0 backup $tar0"
	else
		echo "Snapshot file found."
		echo "Creating level 1 backup..."
		tar -g $snap -cvf $tar1 -C $p $name"/"
		echo "Created level 1 backup $tar1"
	fi
	
	echo "Compression done for $folder"

done < $1

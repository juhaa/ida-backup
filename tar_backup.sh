#!/bin/bash
#
# Usage: sh tar_backup.sh [txt file of directories to backup]
#
# Nov 2016, Juha Mehtonen

files_dir="/home/groups/biowhat/backup_info/files/"

while IFS= read -r folder
do

	name=${folder##*/}
	backup_path=$files_dir${folder##/home/groups/biowhat/}
	[ ! -d "$backup_path" ] && ( mkdir -p "$backup_path" && echo "Created dir '$backup_path'" || ( c=$?; echo "Unable to create  dir '$backup_path'! Exiting..."; (exit $c) ))
	
	snap="${backup_path}/${name}.snar"
	tar0="${backup_path}/${name}-0.tar"
	tar1="${backup_path}/${name}-1.tar"

	echo "Compressing directory $folder"

	if [ ! -f "$snap" ] ; then
		echo "Snapshot file not found. Creating it..."
		echo "Level 0 backup not found. Creating it..."
		tar -g $snap -cvf $tar0 $folder
		echo "Created snapshot file $snap"
		echo "Created level 0 backup $tar0"
	else
		echo "Snapshot file found."
		echo "Creating level 1 backup..."
		tar -g $snap -cvf $tar1 $folder
		echo "Created level 1 backup $tar1"
	fi
	
	echo "Compression done for $folder"

done < $1


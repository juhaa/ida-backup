#!/bin/bash
#
# Usage: sh tar_backup.sh [txt file of directories to backup]
#
# Jun 2017, Juha Mehtonen

files_dir="/home/groups/biowhat/backup_info/new_tars/"

while IFS= read -r folder
do

	name=${folder##*/}
	backup_path=$files_dir${folder##/home/groups/biowhat/}
	[ ! -d "$backup_path" ] && ( mkdir -p "$backup_path" && echo "Created dir '$backup_path'" || ( c=$?; echo "Unable to create  dir '$backup_path'! Exiting..."; (exit $c) ))
	
	snap="${backup_path}/${name}.snar"
	tar0="${backup_path}/${name}-0.tar.gz"
	tar1="${backup_path}/${name}-1.tar.gz"
	log0="${backup_path}/${name}-0.log"
	log1="${backup_path}/${name}-1.log"

	echo "Compressing directory $folder"

	if [ ! -f "$snap" ] ; then
		echo "Snapshot file not found. Creating it..." |& tee -a $log0
		echo "Creating level 0 backup..." |& tee -a $log0
		date |& tee -a $log0
		tar -g $snap -czpf $tar0 $folder |& tee -a $log0
		echo "Created snapshot file $snap" |& tee -a $log0
		echo "Created level 0 backup $tar0" |& tee -a $log0
		date |& tee -a $log0
	else
		echo "Snapshot file found." |& tee -a $log1
		echo "Creating level 1 backup..." |& tee -a $log1
		date |& tee -a $log1
		tar -g $snap -czpf $tar1 $folder |& tee -a $log1
		echo "Created level 1 backup $tar1" |& tee -a $log1
		date |& tee -a $log1
	fi
	
	echo "Compression done for $folder"

done < $1


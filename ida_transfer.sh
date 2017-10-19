#!/bin/bash
#
# Transfers tarballs to IDA
#
# Usage: sh ida_transfer.sh [txt file of directories to transfer]
#
# Oct 2017, Juha Mehtonen

ida_dir="/ida/uef/sysgen/new_backups/"
backup_dir="/home/groups/biowhat/backup_info/"
logs_dir="${backup_dir}logs/"
files_dir="${backup_dir}new_tars/"
retries=8

while IFS= read -r folder
do

	# Set paths and names
	path=${folder##/home/groups/biowhat/}
	ida_path=$ida_dir$path
	backup_path=$files_dir$path
	name=${folder##*/}
	tar0="${backup_path}/${name}-0.tar.gz"
	tar1="${backup_path}/${name}-1.tar.gz"
	logfile="${logs_dir}$(date +%F)/${name}_transfer_$(date +%F).log"

	echo "Starting transfer of $folder"

	# Try transfer level 0 and 1 backups if exists
	if [ -f "$tar0" ] ; then
		echo "Found level 0 backup, starting transfer..."
		./iput_wrapper.bash -l "$tar0" -r "$ida_path" -v -c -a $logfile -b $retries
	else
		echo "No level 0 backup found."
	fi

	if [ -f "$tar1" ] ; then
		echo "Found level 1 backup, starting transfer..."
		./iput_wrapper.bash -l "$tar1" -r "$ida_path" -v -c -a $logfile -b $retries
	else
		echo "No level 1 backup found."
	fi
	
	echo "Transfer done. Check the log: $logfile"

done < $1


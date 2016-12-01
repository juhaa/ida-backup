#!/bin/bash
#
# Transfers tarballs to IDA
#
# Usage: sh ida_transfer.sh [txt file of directories to transfer]
#
# Nov 2016, Juha Mehtonen

ida_dir="/ida/uef/sysgen/"
backup_dir="/home/groups/biowhat/backup_info/"
logs_dir="${backup_dir}logs/"
files_dir="${backup_dir}files/"

[ ! -d "${logs_dir}/$(date +%F)/" ] && ( mkdir "${logs_dir}/$(date +%F)/" )

while IFS= read -r folder
do

	# Remove existing log file if exists
	[ -f "ida_transfer.log" ] && ( rm ida_transfer.log )

	# Set paths and names
	path=${folder##/home/groups/biowhat/}
	ida_path=$ida_dir$path
	backup_path=$files_dir$path
	name=${folder##*/}
	tar0="${backup_path%/*}/${name}-0.tar"
	tar1="${backup_path%/*}/${name}-1.tar"
	snap="${backup_path%/*}/${name}.snar"

	echo "Starting transfer of $folder"

	# Try transfer level 0 and 1 backups if exists
	if [ -f "$tar0" ] ; then
		echo "Found level 0 backup, starting transfer..."
		./iput_wrapper.bash -l "$tar0" -r "$ida_path" -v -c
	else
		echo "No level 0 backup found."
	fi

	if [ -f "$tar1" ] ; then
		echo "Found level 1 backup, starting transfer..."
		./iput_wrapper.bash -l "$tar1" -r "$ida_path" -v -c
	else
		echo "No level 1 backup found."
	fi
	
	# Move and rename log file generated by iput_wrapper.bash
	logfile="${logs_dir}${name}_transfer_$(date +%F).log"
	mv ida_transfer.log $logfile
	echo "Transfer done. Check the log: $logfile"

done < $1

#!/bin/bash
#
# Transfers tarballs to IDA
#
# Usage: sh ida_transfer.sh [txt file of directories to transfer]
#
# Jan 2018, Juha Mehtonen

ida_dir="backups_2018/"
backup_dir="/research/groups/sysgen/PROJECTS/projects_data_management/"
logs_dir="${backup_dir}transfer_logs/server_to_ida/"
files_dir="${backup_dir}backups/"

# IDA v2 tools path
SCRIPTS="/research/groups/sysgen/PROJECTS/projects_data_management/ida-backup/ida2-command-line-tools"

while IFS= read -r folder
do

	# Set paths and names
	path=${folder##/research/groups/}
	ida_path=$ida_dir$path
	backup_path=$files_dir$path
	name=${folder##*/}
	logfolder=${logs_dir}$(date +%F)
	logfile="${logfolder}/${name}_transfer_$(date +%F).log"

	[ ! -d "$logfolder" ] && mkdir -p $logfolder

	echo "Starting transfer of backup of $folder"

	$SCRIPTS/ida upload -v $ida_path $backup_path | tee $logfile

	echo "Transfer done. Check the log: $logfile"

done < $1


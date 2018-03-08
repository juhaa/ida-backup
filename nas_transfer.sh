#!/bin/bash
#
# Transfers tarballs to NAS
#
# Usage: sh nas_transfer.sh [txt file of directories to transfer]
#
# Jan 2018, Juha Mehtonen

nas_dir="/media/biowhat/backups_2018/"
backup_dir="/research/groups/sysgen/PROJECTS/projects_data_management/"
logs_dir="${backup_dir}transfer_logs/server_to_nas/"
files_dir="${backup_dir}backups/"
retries=8

while IFS= read -r folder
do

	# Set paths and names
	path=${folder##/research/groups/}
	nas_path=$nas_dir$path
	backup_path=$files_dir$path
	name=${folder##*/}
	logfile="${logs_dir}$(date +%F)/${name}_transfer_$(date +%F).log"

	# Initialize logfile
	logfile_path="$(dirname $logfile)"
	if [ ! -d "$logfile_path" ]
	then
		mkdir -p "$logfile_path"
	fi

	echo "Starting transfer of backup of $folder"

	rsync -avPu --log-file=$logfile --rsync-path="mkdir -p $nas_path && rsync" $backup_path/ biowhat@10.139.24.204:$nas_path

	echo "Transfer done. Check the log: $logfile"

done < $1


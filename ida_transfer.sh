#!/bin/bash
#
# Transfers tarballs to IDA
#
# Usage: sh ida_transfer.sh [txt file of directories to transfer]
#
# Jan 2018, Juha Mehtonen

ida_dir="/ida/uef/sysgen/backups_2018/"
backup_dir="/research/groups/sysgen/PROJECTS/projects_data_management/"
logs_dir="${backup_dir}transfer_logs/server_to_ida/"
files_dir="${backup_dir}backups/"
retries=8

# Get script folder
SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

while IFS= read -r folder
do

	# Set paths and names
	path=${folder##/research/groups/}
	ida_path=$ida_dir$path
	backup_path=$files_dir$path
	name=${folder##*/}
	logfile="${logs_dir}$(date +%F)/${name}_transfer_$(date +%F).log"

	echo "Starting transfer of backup of $folder"

	$SCRIPTS/iput_wrapper.bash -l $backup_path -r $ida_path -v -c -a $logfile -b $retries

	echo "Transfer done. Check the log: $logfile"

done < $1


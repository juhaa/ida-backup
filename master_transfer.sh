#!/bin/bash
#
# Usage: sh master_transfer.sh [txt file of directories to backup]
#
# Jan 2018, Juha Mehtonen

# Get script folder
SCRIPTS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 1: Make tar backups
$SCRIPTS/tar_backup.sh $1

# 2: Transfer tarballs to NAS
$SCRIPTS/nas_transfer.sh $1

# 3: Transfer tarballs to IDA
$SCRIPTS/ida_transfer.sh $1


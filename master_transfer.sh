#!/bin/bash
#
# Usage: sh master_transfer.sh [txt file of directories to backup]
#
# Jan 2018, Juha Mehtonen

# 1: Make tar backups
./tar_backup.sh $1

# 2: Transfer tarballs to NAS
./nas_transfer.sh $1

# 3: Transfer tarballs to IDA
./ida_transfer.sh $1


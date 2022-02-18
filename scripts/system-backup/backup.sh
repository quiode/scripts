#!/bin/bash
# This script is used to backup the the while filesystem using rsync. It has one argument: the path to the backup directory.
# It deletes the backup directory if it already exists.
# https://wiki.archlinux.org/title/Rsync#Full_system_backup
# Easy to use in combination with cron.

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi
# needs one argument -> the backup destination
if [ $# -ne 1 ] && [ -d "$0" ]; then
    echo "Usage: $0 <backup_directory>"
    exit
fi

rm -r "$0"
mkdir "$0"
rsync -aAXHS --info=progress2 --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / "$0"
#!/bin/bash

rclone copy "/mnt/Media/Anime" "gdrive:Media/Anime" --fast-list -P --transfers 8 --bwlimit 20M --exclude-from /home/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync "/mnt/Media/Anime Movies" "gdrive:Media/Anime Movies" --track-renames --track-renames-strategy hash,modtime,leaf --fast-list -P --transfers 8 --bwlimit 20M --exclude-from /home/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync "/mnt/Media/TV Shows" "gdrive:Media/TV Shows" --track-renames --track-renames-strategy hash,modtime,leaf --fast-list -P --transfers 8 --bwlimit 20M --exclude-from /home/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync "/mnt/Media/Movies" "gdrive:Media/Movies" --track-renames --track-renames-strategy hash,modtime,leaf --fast-list -P --transfers 8 --bwlimit 20M --exclude-from /home/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync "/mnt/Media/Music" "gdrive:Media/Music" --track-renames --track-renames-strategy hash,modtime,leaf --fast-list -P --transfers 24 --bwlimit 20M --exclude-from /home/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync "/mnt/Media/Books" "gdrive:Media/Books" --track-renames --track-renames-strategy hash,modtime,leaf --fast-list -P --transfers 24 --bwlimit 20M --exclude-from /home/noel/Projects/scripts/rclone/rclone_exclude.txt

path=/mnt/Media/Anime
for d in "$path"/*
do
    rclone sync "$d" "gdrive:Media/Anime/${d#$path/}" --track-renames --track-renames-strategy hash,modtime,leaf --fast-list --transfers 8 --exclude-from /home/noel/Projects/scripts/rclone/rclone_exclude.txt
done
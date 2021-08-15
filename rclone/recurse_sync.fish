#!/bin/fish
cd /mnt/a/Anime
for d in *
    echo $d
    rclone.exe sync --track-renames --track-renames-strategy hash,modtime,leaf A:/Anime/$d gdrive:Media/Anime/$d --fast-list --transfers 8 --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
end
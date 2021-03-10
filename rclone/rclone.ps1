rclone copy "A:/Anime" "gdrive:Media/Anime" --fast-list -P --transfers 8 --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "D:/Anime Movies" "gdrive:Media/Anime Movies" --fast-list -P --transfers 8 --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "D:/Movies" "gdrive:Media/Movies" --fast-list -P --transfers 8 --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "D:/TV Shows" "gdrive:Media/TV Shows" --fast-list -P --transfers 8 --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "D:/Music" "gdrive:Media/Music" --fast-list -P --transfers 24 --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "D:/Books" "gdrive:Media/Books" --fast-list -P --transfers 24 --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt

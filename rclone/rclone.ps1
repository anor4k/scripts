rclone copy "A:/Anime" "gdrive:Media/Anime" --fast-list -P --transfers 8 --bwlimit 20M --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
$Path = "A:\Anime"
$ReplaceMe = [Regex]::Escape("A:\")
ForEach ($dir in (Get-ChildItem -Path $Path -Directory)) {
    $dir.FullName
    ($dir.FullName -replace $ReplaceMe,"gdrive:Media/") -replace [Regex]::Escape("\"),"/"
    $Arguments = @(
        "sync",
        "--track-renames",
        "--track-renames-strategy hash,modtime,leaf",
        "`"$($dir.FullName)`"",
        "`"$(($dir.FullName -replace $ReplaceMe,"gdrive:Media/") -replace [Regex]::Escape("\"),"/")`"",
        "--fast-list",
        "--transfers 8",
        "--exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt"
    )
    Start-Process "rclone.exe" -ArgumentList $Arguments -Wait -NoNewWindow
}
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "A:/Anime Movies" "gdrive:Media/Anime Movies" --fast-list -P --transfers 8 --bwlimit 20M --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "A:/Movies" "gdrive:Media/Movies" --fast-list -P --transfers 8 --bwlimit 20M --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "A:/TV Shows" "gdrive:Media/TV Shows" --fast-list -P --transfers 8 --bwlimit 20M --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "A:/Music" "gdrive:Media/Music" --fast-list -P --transfers 24 --bwlimit 20M --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt
rclone sync --track-renames --track-renames-strategy hash,modtime,leaf "A:/Books" "gdrive:Media/Books" --fast-list -P --transfers 24 --bwlimit 20M --exclude-from C:/Users/noel/Projects/scripts/rclone/rclone_exclude.txt

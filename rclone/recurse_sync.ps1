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

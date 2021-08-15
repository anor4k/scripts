#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Shortcuts

; Mute Microphone
*VK97::
SoundSet, +1, MASTER, mute,8
SoundGet, master_mute, , mute,8

if (master_mute = "On") {
SoundPlay, discord_mute.mp3,
}
else {
SoundPlay, discord_unmute.mp3,
}
return

; Open Terminal
#`::
if WinExist("ahk_exe WindowsTerminal.exe")
    WinActivate, ahk_exe WindowsTerminal.exe
Else
    Run, wt
    WinWait, ahk_exe WindowsTerminal.exe
    WinActivate, ahk_exe WindowsTerminal.exe
return

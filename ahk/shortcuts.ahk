#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Shortcuts

#`::
if WinExist("ahk_exe WindowsTerminal.exe")
    WinActivate, ahk_exe WindowsTerminal.exe
Else
    Run, wt
    WinWait, ahk_exe WindowsTerminal.exe
    WinActivate, ahk_exe WindowsTerminal.exe

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include findScriptHWND.ahk

return

F10::
{
	hWnd := findScriptHWND("Find_script_2") ;
	if (hWnd) {
		Tooltip, Exists as %hWnd%, 1400, 630, 2
		setTitle()
		WinClose, ahk_id %hWnd%
		returnTitle()
	} else {
		Tooltip, Does not exist, 1400, 630, 2
	}
}
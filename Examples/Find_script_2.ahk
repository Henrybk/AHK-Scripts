#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global countMain := 1 ;


mainLoop()

return

mainLoop() {
	global ;
	
	loopStart:

	Tooltip, mainLoop countMain is %countMain%, 1400, 660, 3
	countMain += 1 ;

	sleep 300
	
	Goto, loopStart
}
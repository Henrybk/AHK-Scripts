#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include Tunnel.ahk

global Central = new TunnelCentral() ;
global Tunnel_to_1 := new Tunnel("Tunnel_script_1") ;
Central.addTunnel(Tunnel_to_1)

global countReceived := 1 ;

global countMain := 1 ;
global testVar := 0 ;


mainLoop()

return

ReceivedMsg:
{
	Tooltip, MapChange ReceivedMsg countReceived is %countReceived%, 1400, 630, 2
	countReceived += 1 ;
	
	return
}

mainLoop() {
	global ;
	
	loopStart:

	Tooltip, mainLoop countMain is %countMain% - testVar is %testVar%, 1400, 660, 3
	countMain += 1 ;

	sleep 300
	
	Goto, loopStart
}
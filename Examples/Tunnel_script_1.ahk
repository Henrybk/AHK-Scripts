#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include Tunnel.ahk

global Central = new TunnelCentral() ;
global Tunnel_to_2 := new Tunnel("Tunnel_script_2") ;
Central.addTunnel(Tunnel_to_2)


mainLoop()

return

mainLoop() {
	global ;
	
	loopStart:

	Tooltip, Tunnel Script 1 Sending runlabel ReceivedMsg to Script 2, 900, 600, 1
	
	re := Tunnel_to_2.runlabel("ReceivedMsg", 1, 200, 1)
	
	if (re != "FAIL") {
		Tooltip, runlabel on Tunnel worked - result is %re%, 900, 630, 2
	} else {
		Tooltip, runlabel on Tunnel failed, 900, 630, 2
	}

	sleep 500
	
	Goto, loopStart
}
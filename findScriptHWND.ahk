/*

###########################
findScriptHWND v1.0       #
By Henrybk                #
###########################

##################################
Licensed Under MIT License	     #
##################################

*/

findScriptHWND(TargetScriptTitle) {
	global ;
	setTitle()
	hWnd := WinExist(TargetScriptTitle . " ahk_class AutoHotkey") ;
	returnTitle()
	return hWnd
}

setTitle() {
	global ;
	
	Prev_DetectHiddenWindows := A_DetectHiddenWindows
	Prev_TitleMatchMode := A_TitleMatchMode
	
	DetectHiddenWindows On
	SetTitleMatchMode 2
}

returnTitle() {
	global ;
	
	DetectHiddenWindows %Prev_DetectHiddenWindows%
    SetTitleMatchMode %Prev_TitleMatchMode%
}
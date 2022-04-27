/*

###########################
Tunnel v0.92              #
By Henrybk                #
###########################

##################################
Licensed Under MIT License	     #
##################################

*/

global separator := " \ " ;
global separatorLen := StrLen(separator) ;
global listenersList := [] ;

class TunnelCentral {
	__New() {
		global ;
		listenersList := []
		OnMessage(0x4a, "listen_to_message") ;
	}
	
	addTunnel(Tunnel) {
		global ;
		listenersList[Tunnel.targetScriptName] := Tunnel ;
	}
	
	removeTunnel(Tunnel) {
		global ;
		listenersList.delete(Tunnel.targetScriptName) ;
	}
}

listen_to_message(wParam, lParam) {
	global ;
	local Data, FirstArgStart, FirstArgEnd, FirstArgLen, SecArgStart, SecArgEnd, SecArgLen, ThirdArgStart, ThirdArgEnd, ThirdArgLen, FourthArgStart, FirstArg, SecArg, ThirdArg, FourthArg ;
	
	StringAddress := NumGet(lParam + 2*A_PtrSize)  ; Retrieves the CopyDataStruct's lpData member.
    Data := StrGet(StringAddress)  ; Copy the string out of the structure.
	
	FirstArgStart := 1 ;
	FirstArgEnd := Instr(Data, separator, false, 1) - 1 ;
	FirstArgLen := FirstArgEnd - FirstArgStart + 1 ;
	
	SecArgStart := FirstArgEnd + 1 + separatorLen ;
	SecArgEnd := Instr(Data, separator, false, SecArgStart) - 1 ;
	SecArgLen := SecArgEnd - SecArgStart + 1 ;
	
	ThirdArgStart := SecArgEnd + 1 + separatorLen ;
	ThirdArgEnd := Instr(Data, separator, false, ThirdArgStart) - 1 ;
	ThirdArgLen := ThirdArgEnd - ThirdArgStart + 1 ;
	
	FourthArgStart := ThirdArgEnd + 1 + separatorLen ;
	
	FirstArg := Substr(Data, FirstArgStart, FirstArgLen) ;
	SecArg := Substr(Data, SecArgStart, SecArgLen) ;
	ThirdArg := Substr(Data, ThirdArgStart, ThirdArgLen) ;
	FourthArg := Substr(Data, FourthArgStart) ;
	;FirstArg := From
	;SecArg := Order
	;ThirdArg := Parameter 1
	;FourthArg := Parameter 2
	
	if (ObjHasKey(listenersList, FirstArg)) {
		listenersList[FirstArg].receive_message(FirstArg, SecArg, ThirdArg, FourthArg)
		return true ;
	} else {
		return false ;
	}
}

class Tunnel {
	__New(target) {
		this.targetScriptName := target ;
		this.myScriptName := RegExReplace(A_ScriptName, "(.\w*$)") ;
	}
	
	; forceful close method?
	WM_close() {
		ret := SendToScript(0, 0x0010, 0, this.targetScriptName) ; WM_CLOSE = 0x0010 ; 
		return ret ;
	}
	
	; tray exit button
	close() {
		ret := SendToScript(0, 0x111, 65307, this.targetScriptName) ; WM_COMMAND = 0x0111 ; ID_TRAY_EXIT = 65307
		return ret ;
	}

	reload() {
		ret := SendToScript(0, 0x0111, 65303, this.targetScriptName) ; WM_COMMAND = 0x0111 ; ID_TRAY_RELOADSCRIPT = 65303
		return ret ;
	}

	pause() {
		ret := SendToScript(0, 0x0111, 65306, this.targetScriptName) ; WM_COMMAND = 0x0111 ; ID_TRAY_PAUSE = 65306
		return ret ;
	}

	suspend() {
		ret := SendToScript(0, 0x0111, 65305, this.targetScriptName) ; WM_COMMAND = 0x0111 ; ID_TRAY_SUSPEND = 65305
		return ret ;
	}
	
	runlabel(label, wait, timer, retry) {
		StringToSend := this.myScriptName . separator . "runlabel" . separator . label . separator . "nill" ;
		if (wait = 1) {
			this.answer_runlabel := 0 ;
			time_Now := A_TickCount ;
			time_Max := time_Now + timer ;
			tried := 0 ;
			while (1) {
				if (retry = 1 or tried = 0) {
					SendToScript(1, 0x004A, StringToSend, this.targetScriptName)
					tried := 1 ;
				}
				sleep, 50
				if (this.answer_runlabel = 1) {
					this.answer_runlabel := 0 ;
					return 1 ;
				} else {
					time_Now := A_TickCount ;
					if (time_Now > time_Max) {
						return 0 ;
					}
				}
			}
		} else {
			ret := SendToScript(1, 0x004A, StringToSend, this.targetScriptName)
			return ret ;
		}
	}
	
	setvar(var_name, var_value, wait, timer, retry) {
		StringToSend := this.myScriptName . separator . "setvar" . separator . var_name . separator . var_value ;
		if (wait = 1) {
			this.answer_setvar := 0 ;
			time_Now := A_TickCount ;
			time_Max := time_Now + timer ;
			tried := 0 ;
			while (1) {
				if (retry = 1 or tried = 0) {
					SendToScript(1, 0x004A, StringToSend, this.targetScriptName)
					tried := 1 ;
				}
				sleep, 50
				if (this.answer_setvar = 1) {
					this.answer_setvar := 0 ;
					return 1 ;
				} else {
					time_Now := A_TickCount ;
					if (time_Now > time_Max) {
						return 0 ;
					}
				}
			}
		} else {
			ret := SendToScript(1, 0x004A, StringToSend, this.targetScriptName)
			return ret ;
		}
	}
	
	receive_message(FirstArg, SecArg, ThirdArg, FourthArg) {
		;FirstArg := From
		;SecArg := Order
		;ThirdArg := Parameter 1
		;FourthArg := Parameter 2
		
		if (SecArg = "answer") {
			if (ThirdArg = "runlabel") {
				this.answer_runlabel := 1 ;
			} else  if (ThirdArg = "setvar") {
				this.answer_setvar := 1 ;
			}
		
		} else if (SecArg = "runlabel") {
			if (islabel(ThirdArg)) {
				gosub, %ThirdArg% ;
			}
			StringToSend := this.myScriptName . separator . "answer" . separator . "runlabel" . separator . "nill" ;
			SendToScript(1, 0x004A, StringToSend, this.targetScriptName)
		
		} else if (SecArg = "setvar") {
			%ThirdArg% := FourthArg ;
			StringToSend := this.myScriptName . separator . "answer" . separator . "setvar" . separator . "nill" ;
			SendToScript(1, 0x004A, StringToSend, this.targetScriptName)
		}
	}
}

SendToScript(isString, Msg, Param, TargetScriptTitle) {
	Tunnel_Prev_DetectHiddenWindows := A_DetectHiddenWindows
	Tunnel_Prev_TitleMatchMode := A_TitleMatchMode
	
	DetectHiddenWindows On
	SetTitleMatchMode 2
	
	Tunnel_hWnd := WinExist(TargetScriptTitle . " ahk_class AutoHotkey") ;
	
	if (!Tunnel_hWnd) {
		DetectHiddenWindows %Tunnel_Prev_DetectHiddenWindows%
		SetTitleMatchMode %Tunnel_Prev_TitleMatchMode%
		return "Script hWnd not found"
	} else {
		if (isString = 1) {
			VarSetCapacity(CopyDataStruct, 3*A_PtrSize, 0) ;
			SizeInBytes := (StrLen(Param) + 1) * (A_IsUnicode ? 2 : 1) ;
			NumPut(SizeInBytes, CopyDataStruct, A_PtrSize) ;
			NumPut(&Param, CopyDataStruct, 2*A_PtrSize) ;
			SendMessage, Msg, 0, &CopyDataStruct,, ahk_id %Tunnel_hWnd% ;
		} else {
			SendMessage, Msg, Param,,, ahk_id %Tunnel_hWnd% ;
		}
		
		DetectHiddenWindows %Tunnel_Prev_DetectHiddenWindows%
		SetTitleMatchMode %Tunnel_Prev_TitleMatchMode%
		return ErrorLevel ;
	}
	
}
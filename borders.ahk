/*

###########################
borders v1.0              #
By Henrybk                #
###########################

##################################
Licensed Under MIT License	     #
##################################

*/

removeBorders(hwnd) {
	if (hWnd) {
		if (WindowHasBorders(hWnd)) {
			windowRemoveBorders(hwnd)
		}
	}
	return
}

addBorders(hwnd) {
	if (hWnd) {
		if (!WindowHasBorders(hWnd)) {
			windowAddBorders(hwnd)
		}
	}
	return
}

ToogleBorders(hwnd) {
	if (hWnd) {
		if (WindowHasBorders(hWnd)) {
			windowRemoveBorders(hwnd)
		} else {
			windowAddBorders(hwnd)
		}
	}
	return
}

windowAddBorders(hwnd) {
	; Add borders back
	window := WinGetPosWindow(hWnd)
	
	WinSet, Style, +0xC00000, ahk_id %hWnd%
	WinSet, Style, +0x40000, ahk_id %hWnd%
	
	WinMove, ahk_id %hWnd%,, window.x, window.y, window.w, window.h
	return
}

windowRemoveBorders(hwnd) {
	; Remove borders
	client := WinGetPosClient(hWnd)
	
	WinSet, Style, -0xC00000, ahk_id %hWnd%
	WinSet, Style, -0x40000, ahk_id %hWnd%
	
	WinMove, ahk_id %hWnd%,, client.x, client.y, client.w, client.h
	return
}

WindowHasBorders(hwnd) {
	if (!hwnd) {
		return 0
	}
	
	WinGet, WindowStyle, Style, ahk_id %hWnd%
	if (WindowStyle & +0xC00000) {
		return 1
	} else {
		return 0
	}
}

WinGetPosClient(hwnd) {

	if (!hwnd) {
		return {x: 0, y: 0, w: 0, h: 0}
	}
	
	WinGetPos, rx, ry, rw, rh, ahk_id %hwnd%

	; subtract window frame
	WinGet style, style, ahk_id %hwnd%
	if style & 0xc00000 {	; bordered window, get client area
		SysGet cap, 4			; caption height
		SysGet bw, 32			; border width
		SysGet bh, 33			; border height
		rx += bw, ry += (cap + bh), rw -= (bh * 2), rh -= (cap + bh * 2)
	}
	
	return {x: rx, y: ry, w: rw, h: rh}
}

WinGetPosWindow(hwnd) {

	if (!hwnd) {
		return {x: 0, y: 0, w: 0, h: 0}
	}
	
	WinGetPos, rx, ry, rw, rh, ahk_id %hwnd%

	; subtract window frame
	WinGet style, style, ahk_id %hwnd%
	if (style & 0xc00000) {	; bordered window, get client area
	} else {
		SysGet cap, 4			; caption height
		SysGet bw, 32			; border width
		SysGet bh, 33			; border height
		rx -= bw, ry -= (cap + bh), rw += (bh * 2), rh += (cap + bh * 2)
	}
	
	return {x: rx, y: ry, w: rw, h: rh}
}
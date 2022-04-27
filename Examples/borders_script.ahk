
#Include borders.ahk

return

F11::
{
	hWnd := WinActive("AHK_exe mspaint.exe") ;
	if (hWnd) {
		ToogleBorders(hwnd)
	}
	return
}
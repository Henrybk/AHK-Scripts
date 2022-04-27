#Include pixelManipulation.ahk

CoordMode, Pixel, client

global coordX1 := 1800 ;
global coordY1 := 110 ;
global coordX2 := 1830 ;
global coordY2 := 95 ; 

F10::
{
	pixelgetcolor, alfa1, coordX1, coordY1
	alfa1 := new pixel(alfa1) ;
	
	pixelgetcolor, alfa2, coordX2, coordY2
	alfa2 := new pixel(alfa2) ;
	
	maxDiff := compare_pixel_colors(alfa1, alfa2) ;
	
	Tooltip, Color diference is %maxDiff%, 1400, 630, 2
}
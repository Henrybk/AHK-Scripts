/*

###########################
pixelCompare v1.0         #
By Henrybk                #
###########################

##################################
Licensed Under MIT License	     #
##################################

*/

class pixel
{
	__New(pixel_o) {
		global ;
		this.B := (pixel_o >> 16) & 0xFF   ;
		this.G := (pixel_o >>  8) & 0xFF   ;
		this.R :=  pixel_o        & 0xFF   ;
		
		this.string := this.R . " " . this.G . " " . this.B
	}
}

compare_pixel_colors(pixel_1, pixel_2) {
	diffR := abs(pixel_1.R - pixel_2.R) ;
	diffG := abs(pixel_1.G - pixel_2.G) ;
	diffB := abs(pixel_1.B - pixel_2.B) ;
	maxDiff := max(diffR, diffG, diffB) ;
	return maxDiff
}

compare_pixel_red(pixel_1, pixel_2) {
	diffR := abs(pixel_1.R - pixel_2.R) ;
	return diffR
}

compare_pixel_green(pixel_1, pixel_2) {
	diffG := abs(pixel_1.G - pixel_2.G) ;
	return diffG
}

compare_pixel_blue(pixel_1, pixel_2) {
	diffB := abs(pixel_1.B - pixel_2.B) ;
	return diffB
}
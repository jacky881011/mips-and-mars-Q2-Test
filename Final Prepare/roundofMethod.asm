.data
	flo: .float 12.333333
	f2: .float 2
	
	hundf1: .float 100
	zerof: .float 0.0
	

.text
main:
	lwc1 $f3, hundf1
	lwc1 $f10, zerof
	lwc1 $f2, flo
	
	
	mul.s $f2, $f3, $f2
	round.w.s $f2, $f2
	mfc1 $s0, $f2
	mtc1 $s0, $f2
	cvt.s.w $f2, $f2
	
	
	div.s $f4, $f2, $f3
	li $v0, 2
	add.s $f12, $f4, $f10
	syscall 
	
	li $v0, 10
	syscall
.data
	pt1: .asciiz "Enter your height: "
	pt2: .asciiz "Enter your weight: "
	bmi: .asciiz "Your BMI is: "
	good: .asciiz "Good result! "
	
	zerof: .float 0.0
	hundf: .float 100.0
	
	space: .asciiz " "
	line: .asciiz "\n"
	comma: .asciiz ","
	
	
	l1: .float 18.5
	l2: .float 24.0
	
.text 
main:
	lwc1 $f10, zerof	# lwc1: means to load the float number from the .data
	lwc1 $f11, hundf
	jal setValue		# jump and link the function 
	
	
	# check the input value
	c.lt.s $f1, $f10	# c.lt.s means check the $f1 < $f10, true than use bc1t to jump to the taget address
	bc1t returnZero
	
	c.lt.s $f2, $f10
	bc1t returnZero
	
	
	li $v0, 4
	la $a0, line
	syscall
	
	# compute the bmi 
	li $v0, 4
	la $a0, bmi
	syscall
	
	div.s $f3, $f1, $f11		# divide 100.0 
	mul.s $f3, $f3, $f3		# mul two times of the parent
	div.s $f4, $f2, $f3		# follow the result to find the output
	
	
	# change to get the presision of the float
	mul.s $f4, $f4, $f11		# multiple the 100
	round.w.s $f4, $f4 		# get the rid of the presision number
	mfc1 $s0, $f4			# move from coprocesser 1
	mtc1 $s0, $f4			# move to coprocesser 1
	cvt.s.w	$f4, $f4		# convert from word to single presision
	div.s $f4, $f4, $f11
	
	
	
	
	
	li $v0, 2			# we use 2 to show the float number!
	add.s $f12, $f4, $f10		# to be careful that the $f12 means like an $a0, to show the float output
	syscall
	
	li $v0, 4
	la $a0, line
	syscall
	
	
	# compare the result, $f4 = BMI
	lwc1 $f20, l1
	lwc1 $f21, l2
	
	
	c.lt.s $f4, $f20
	bc1t returnNegOne
	
	c.lt.s $f21, $f4
	bc1t returnNegTwo
	
	
	li $v0, 4
	la $a0, line
	syscall
	li $v0, 4
	la $a0, good
	syscall
	
	#exit
	exit:
	li $v0, 10
	syscall
	
	
setValue:
	li $v0, 4
	la $a0, pt1
	syscall
	
	li $v0, 6		# 6: means input the float number
	syscall
	add.s $f1, $f0, $f10	# when user input the function then pc will store to the $f0
	
	li $v0, 4
	la $a0, pt2
	syscall
	
	li $v0, 6
	syscall
	add.s $f2, $f0, $f10
	
	jr $ra
	
	
returnZero:
	li $v0, 1
	addi $a0, $zero, 0
	syscall
	
	jal exit		# this can jump back to the exit function
	
	
returnNegOne:
	li $v0, 1
	addi $a0, $zero, -1
	syscall
	
	jal exit
	
returnNegTwo:

	li $v0, 1
	addi $a0, $zero, -2
	syscall
	
	jal exit
	
	
	
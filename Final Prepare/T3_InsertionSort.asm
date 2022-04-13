#Insertion Sort

.data
	pt1: .asciiz "Enter your size of the array: "
	pt2: .asciiz "Insertion Sorted!"
	
	space: .asciiz " "
	line: .asciiz "\n"
	comma: .asciiz ","
	lc: .asciiz "[ "
	rc: .asciiz " ]"
	
	arr: .word 1:20 	# you need to set a  20 space of the array
	
	
.text 
main:
	li $v0, 4
	la $a0, pt1
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0	# store the input array
	
	la $s0, arr		# store the array to the address
	
	# Need to store the function valuable to the $a0, $a1
	addi $a0, $s0, 0
	addi $a1, $s1, 0
	
	
	# Begin to do
	jal Input
	
	jal Sort
	
	jal Print
	
	li $v0, 4
	la $a0, rc
	syscall
	
	exit:
	li $v0, 10
	syscall
	
Input:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 0($sp)
	
	addi $s0, $zero, 0
	forInput:
		slt $t1, $s0, $a1
		beq $t1, $zero, endInput
		
		li $v0, 5
		syscall
		addi $s3, $v0, 0
		
		addi $t2, $s0, 0
		sll $t2, $t2, 2
		add $t2, $a0, $t2
		sw $s3, 0($t2)
		
	
	loopInput:
	addi $s0, $s0, 1
	j forInput
	
	endInput:
	lw $s0, 0($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 8
	jr $ra


Sort:
	addi $sp, $sp, -24
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	sw $s2, 20($sp)
	
	
	addi $s0, $zero, 1
	for1:
		slt $t1, $s0, $a1
		beq $t1, $zero, endSort
		
		addi $s1, $s0, 0
		while2:	
			slt $t1, $zero, $s1
			beq $t1, $zero, loop1
			
			addi $t2, $s1, 0
			sll $t2, $t2, 2
			add $t2, $a0, $t2
			lw $t3, 0($t2)
			
			addi $t4, $s1, -1
			sll $t4, $t4, 2
			add $t4, $a0, $t4
			lw $t5, 0($t4)
			
			slt $t1, $t3, $t5
			beq $t1, $zero, loop1
			
			lw $s2, 0($t2)
			sw $t5, 0($t2)
			sw $s2, 0($t4)
			
			addi $s1, $s1, -1
			
			j while2
			

	loop1:
	addi $s0, $s0, 1
	j for1
	
	endSort:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	lw $s0, 12($sp)
	lw $s1, 16($sp)
	lw $s2, 20($sp)
	addi $sp, $sp, 24
	jr $ra


Print:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	li $v0, 4
	la $a0, lc
	syscall
	
	
	
	addi $s0, $zero, 0
	
	forPrint:
		slt $t1, $s0, $a1
		beq $t1, $zero, endPrint
		
		la $a0, arr			# must reload the array back to the function
		
		addi $t2, $s0, 0
		sll $t2, $t2, 2
		add $t2, $a0, $t2
		lw $s5, 0($t2)
		
		li $v0, 1
		addi $a0, $s5, 0
		syscall
		
		addi $s6, $a1, -1
		beq $s6, $s0, endPrint
		
		li $v0, 4
		la $a0, comma
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
	
	loopPrint:
	addi $s0, $s0, 1
	j forPrint

	
	endPrint:
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	
	
	
	


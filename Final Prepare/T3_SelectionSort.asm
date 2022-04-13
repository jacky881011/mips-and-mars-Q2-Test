.data
# Selection Sort
	pt: .asciiz "Enter your size of the array: "
	
	space: .asciiz " "
	line: .asciiz "\n"
	comma: .asciiz "," 
	rc: .asciiz "]"
	lc: .asciiz "["
	
	arr: .word 1:20

.text 
main:
	li $v0, 4
	la $a0, pt
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0
	
	la $s0, arr
	
	# Store the value to the function input
	addi $a0, $s0, 0
	addi $a1, $s1, 0
	
	jal Input
	
	jal Sort

	jal Print
	
	exit:
	li $v0, 10
	syscall
	
Input:
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	
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
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	


Sort:
	addi $sp, $sp, -28
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $ra, 8($sp)
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	sw $s2, 20($sp)
	sw $s3, 24($sp)
	
	addi $s0, $zero, 0
	addi $s5, $a1, -1
	for1:
		slt $t1, $s0, $s5
		beq $t1, $zero, endSort
		
		addi $s3, $s0, 0
		addi $s1, $s0, 1
		for2:
			slt $t1, $s1, $a1
			beq $t1, $zero, If1
			
			addi $t2, $s1, 0
			sll $t2, $t2, 2
			add $t2, $a0, $t2
			lw $t3, 0($t2)
			
			addi $t4, $s3, 0
			sll $t4, $t4, 2
			add $t4, $a0, $t4
			lw $t5, 0($t4)
			
			slt $t1, $t3, $t5
			beq $t1, $zero, loop2
			
			addi $s3, $s1, 0
		
		loop2:
		addi $s1, $s1, 1
		j for2
		
		If1:  #swap
		addi $t2, $s3, 0
		sll $t2, $t2, 2
		add $t2, $a0, $t2
		lw $s2, 0($t2)
		
		addi $t4, $s0, 0
		sll $t4, $t4, 2
		add $t4, $a0, $t4
		lw $t5, 0($t4)
		
		sw $t5, 0($t2)
		sw $s2, 0($t4)
		
	
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
	lw $s3, 24($sp)
	addi $sp, $sp, 28
	jr $ra


Print:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	addi $s0 ,$zero, 0
	
	forPrint:
		slt $t1, $s0, $a1
		beq $t1, $zero, endPrint
		
		la $a0, arr		# must reload the address from the array
		
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
	
	



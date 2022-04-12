.data 
	pt1: .asciiz "This is the pointer to initialize the array! "
	pt2: .asciiz "This is the array to initialize the array!"
	choose: .asciiz "Choose the function to set the element to array 1: Pointer, 2: Array!\n Input value: "
	
	pt: .asciiz "Please enter the size of the array!\nSize: "
	space: .asciiz " "
	line: .asciiz "\n"
	comma: .asciiz ","
	
	arr: .word 1:20 		# set the 80 bytes for the word
	
	
.text
main:
	li $v0, 4
	la $a0, pt
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0	#store the input size from the user
	
	la $s0, arr		#load the address to get the array
	
	# Input elements to the array
	addi $s2, $zero, 0
	
	forInput:
		slt $t1, $s2, $s1
		beq $t1, $zero, endInput
		
		li $v0, 5
		syscall
		addi $s5, $v0, 0	# store the user input to $s5
		
		# store to the array
		addi $t2, $s2, 0
		sll $t2, $t2, 2
		add $t2, $s0, $t2
		sw $s5, 0($t2)		# store the value to arr[]
		
		
	loopInput:
	addi $s2, $s2, 1
	j forInput
	
	endInput:
	
	
	
	# Choose which you want to set the value
	li $v0, 4
	la $a0, line
	syscall
	li $v0, 4
	la $a0, choose
	syscall
	
	li $v0, 5
	syscall
	li $s7, 2
	beq $v0, $s7, ArraySet
	
	
	
	# use the pointer to set the 1 ~ N
	PointerSet:
	li $v0, 4
	la $a0, pt1
	syscall
	
	
	move $t0, $s0		# store the array into the pointer $t0 = *arr
	sll $t2, $s1, 2		# set the maxmum size to the pointer
	add $t2, $s0, $t2	# store the *arr[size]
	addi $s5, $zero, 1	# we want to set inside the value
	forPointerSet:
		slt $t1, $t0, $t2
		beq $t1, $zero, endPointerSet
		
		sw $s5, 0($t0)
		
	
	loopPointerSet:
	addi $s5, $s5, 1
	addi $t0, $t0, 4	# see that the pointer set the 
	j forPointerSet
	
	
	endPointerSet:
	jal PrintArray
	
	
	
	# use Array to set the function 
	ArraySet:
	li $v0, 4
	la $a0, pt2
	syscall
	li $v0, 4
	la $a0, line
	syscall
	
	addi $s2, $zero, 0
	addi $s5, $s1, 0
	forArraySet:
		slt $t1, $s2, $s1
		beq $t1, $zero, endArraySet
		
		addi $t2, $s2, 0
		sll $t2, $t2, 2
		add $t2, $s0, $t2
		sw $s5, 0($t2)
		
	
	loopArraySet:
	addi $s5, $s5, -1
	addi $s2, $s2, 1
	j forArraySet
	
	endArraySet:
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	# Print the array
	PrintArray:
	
	
	addi $s2, $zero, 0		# initialize the $s2
	
	forPrint:
		slt $t1, $s2, $s1
		beq $t1, $zero, endPrint
		
		addi $t2, $s2, 0
		sll $t2, $t2, 2
		add $t2, $s0, $t2
		lw $s5, 0($t2)
		
		li $v0, 1
		addi $a0, $s5, 0
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
	
	loopPrint:
	addi $s2, $s2, 1
	j forPrint
	
	endPrint:
	
	
	
	
	
	
	
	
	#exit
	li $v0, 10
	syscall


	
	
	
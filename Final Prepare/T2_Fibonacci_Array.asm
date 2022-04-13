.data 
	pt1: .asciiz "Enter your fib number: "
	space: .asciiz " "
	
.text
main: 
	 li $v0, 4
	 la $a0, pt1
	 syscall
	 
	 li $v0, 5
	 syscall
	 addi $s1, $v0, 0
	 
	 # present the value output
	 addi $s2, $zero, 1
	 forPrint:
	 	sle $t1, $s2, $s1
	 	beq $t1, $zero, endPrint
	 	
	 	addi $a0, $s2, 0
	 	jal Fib
	 	
	 	addi $s4, $v0, 0		# get the return number
	 	
	 	li $v0, 1
	 	addi $a0, $s4, 0
	 	syscall
	 	
	 	li $v0, 4
	 	la $a0, space
	 	syscall
	 	
	 	
	 
	 	
	 	
	loopPrint:
	addi $s2, $s2, 1
	j forPrint
	
	endPrint:
	 
	 
	 
	 
	 exit:
	 li $v0, 10
	 syscall
	 

Fib:		# the function name
	bgt $a0, 1, recu
	addi $v0, $a0, 0
	jr $ra
	
recu:
	addi $sp, $sp, -12		# if we use stack to store the word we first give tge size to it!
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	addi $a0, $a0, -1		# store the $a0, and add -1
	jal Fib				# jump back to the Fib function
	
	sw $v0, 8($sp)			# add store the $v0, to the stack final to check th 
	lw $a0, 4($sp)
	addi $a0, $a0, -2
	jal Fib
	
	lw $t0, 8($sp)
	add $v0, $v0, $t0
	lw $ra, 0($sp)
	addi $sp, $sp, 12		# at the end of the stack we need to add the value back to the stack
	jr $ra
	
	
	
	
	